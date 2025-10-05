require 'redis'
require 'json'

class Turno
  KEY_PENDIENTES = ENV.fetch('REDIS_KEY_PENDIENTES', 'turnos_pendientes')
  KEY_ATENDIDOS  = ENV.fetch('REDIS_KEY_ATENDIDOS',  'turnos_atendidos')

  def self.redis
    @redis ||= Redis.new(host: 'redis', port: 6379, db: 0)
  end

  def self.normalizar(h)
    {
      'nombre'   => h['nombre']   || h[:nombre],
      'servicio' => h['servicio'] || h[:servicio],
      'hora'     => h['hora']     || h[:hora]
    }
  end

  # productor interno (lo usa el consumidor STOMP)
  def self.agregar_pendiente(turno_hash)
    payload = normalizar(turno_hash).to_json
    redis.lpush(KEY_PENDIENTES, payload)
    payload
  end

  def self.obtener_pendientes
    redis.lrange(KEY_PENDIENTES, 0, -1).map { |t| JSON.parse(t) }
  end

  # atiende el siguiente turno (movimiento atómico)
  def self.atender_siguiente
    data = redis.rpoplpush(KEY_PENDIENTES, KEY_ATENDIDOS)
    data ? JSON.parse(data) : nil
  end
end
