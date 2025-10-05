require 'stomp'
require 'socket'
require 'json'

def esperar_activemq(host, port, max_intentos = 20)
  puts "Esperando ActiveMQ (#{host}:#{port})..."
  intentos = 0

  loop do
    begin
      Socket.tcp(host, port, connect_timeout: 2) { |sock| sock.close }
      break
    rescue StandardError
      intentos += 1
      if intentos >= max_intentos
        raise "No se pudo conectar a ActiveMQ en #{host}:#{port} después de #{max_intentos} intentos"
      end
      sleep 2
    end
  end

  puts "ActiveMQ disponible en #{host}:#{port}"
end

# Inicia conexión global
esperar_activemq('activemq', 61613)
ActiveMQ_CLIENT = Stomp::Client.new('admin', 'admin', 'activemq', 61613)
puts "Conectado exitosamente a ActiveMQ"

# Hilo que escucha mensajes y guarda en Redis
Thread.new do
  require 'redis'
  redis = Redis.new(host: ENV['REDIS_HOST'] || 'infraestructura-turnos-redis', port: 6379)

  puts "Escuchando mensajes en /queue/turnos..."
  ActiveMQ_CLIENT.subscribe('/queue/turnos') do |msg|
    begin
      data = JSON.parse(msg.body)
      redis.set("turno:#{data['nombre']}:#{data['hora']}", msg.body)
      puts "Turno guardado en Redis: #{data['nombre']} - #{data['servicio']}"
    rescue => e
      puts "Error procesando mensaje: #{e.message}"
    end
  end
end

# Cierra conexión limpia al detener el servicio
at_exit do
  if defined?(ActiveMQ_CLIENT) && ActiveMQ_CLIENT.open?
    ActiveMQ_CLIENT.close
    puts "Conexión con ActiveMQ cerrada correctamente"
  end
end