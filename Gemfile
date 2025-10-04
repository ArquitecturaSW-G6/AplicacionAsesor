source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.9'

# Framework principal
gem 'rails', '~> 7.1.0'

# Servidor web
gem 'puma', '~> 5.0'

# Adaptadores y utilidades
gem 'redis', '~> 5.0'           # Conexión a Redis
gem 'stomp', '~> 1.4'           # Cliente ActiveMQ
gem 'connection_pool'           # Pool de conexiones Redis
gem 'rack-cors'                 # Permitir peticiones desde las apps Android

# Optimización de arranque
#gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  #gem 'spring'
end

# Para Windows (si lo usas localmente)
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]