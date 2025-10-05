require 'stomp'
require 'json'

Thread.new do
  begin
    Rails.logger.info "Esperando ActiveMQ (activemq:61613)..."
    stomp = Stomp::Client.new('admin', 'admin', 'activemq', 61613, '/')
    Rails.logger.info "ActiveMQ disponible en activemq:61613"

    stomp.subscribe('/queue/turnos', ack: 'auto') do |msg|
      begin
        data = JSON.parse(msg.body)
        Turno.agregar_pendiente(data)
        Rails.logger.info "Turno guardado en Redis: #{data['nombre']} - #{data['servicio']}"
      rescue => e
        Rails.logger.error "Error procesando mensaje: #{e.message}"
      end
    end

    Rails.logger.info "Escuchando mensajes en /queue/turnos..."
  rescue => e
    Rails.logger.error "Error conectando a ActiveMQ: #{e.message}"
  end
end
