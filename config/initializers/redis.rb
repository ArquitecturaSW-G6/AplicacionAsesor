require 'redis'
$redis = Redis.new(host: ENV['REDIS_HOST'] || 'infraestructura-turnos-redis', port: 6379)
