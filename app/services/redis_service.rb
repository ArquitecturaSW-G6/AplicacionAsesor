# app/services/redis_service.rb
require 'redis'
require 'json'

class RedisService
  def self.client
    @client ||= Redis.new(host: 'redis', port: 6379)
  end

  def self.guardar_turno(turno)
    client.rpush('turnos_pendientes', turno.to_json)
  end

  def self.obtener_turnos
    turnos = client.lrange('turnos_pendientes', 0, -1)
    turnos.map { |t| JSON.parse(t) }
  end

  def self.mover_a_atendidos(turno)
    all = obtener_turnos
    nuevo = all.reject { |t| t == turno }
    client.del('turnos_pendientes')
    nuevo.each { |t| client.rpush('turnos_pendientes', t.to_json) }
  end
end
