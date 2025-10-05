require 'stomp'
require 'json'

Thread.new do
  client = ActiveMQ_CLIENT
  client.subscribe('/queue/turnos_queue') do |msg|
    data = JSON.parse(msg.body)
    puts "📩 Mensaje recibido: #{data['nombre']} solicitó #{data['servicio']} a las #{data['hora']}"
  end
  sleep
end