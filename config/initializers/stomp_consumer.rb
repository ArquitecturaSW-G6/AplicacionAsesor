# config/initializers/stomp_consumer.rb
require 'stomp'
require_relative '../../app/services/redis_service'

Thread.new do
  puts "Esperando ActiveMQ (activemq:61613)..."
  sleep 5 until TCPSocket.new('activemq', 61613) rescue false
  puts "ActiveMQ disponible en activemq:61613"

  client = Stomp::Client.new('admin', 'admin', 'activemq', 61613, true)
  puts "Conectado exitosamente a ActiveMQ"
  client.subscribe('/queue/turnos') do |msg|
    begin
      turno = JSON.parse(msg.body)
      RedisService.guardar_turno(turno)
      puts "Turno guardado en Redis: #{turno['nombre']} - #{turno['servicio']}"
    rescue => e
      puts " Error procesando mensaje: #{e.message}"
    end
  end

  puts "Escuchando mensajes en /queue/turnos..."
  sleep
rescue => e
  puts " Error general en el consumidor STOMP: #{e.message}"
ensure
  client&.close
  puts "Conexión con ActiveMQ cerrada correctamente"
end
