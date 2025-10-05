require "redis"

# Conexión única simple (suficiente para el taller)
$redis = Redis.new(url: ENV.fetch("REDIS_URL", "redis://redis:6379/0"))

# Si más adelante necesitas pool:
# require "connection_pool"
# $redis = ConnectionPool.new(size: 5) { Redis.new(url: ENV.fetch("REDIS_URL", "redis://redis:6379/0")) }
