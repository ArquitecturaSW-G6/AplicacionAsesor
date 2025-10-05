source "https://rubygems.org"

ruby "3.2.9"

gem "rails", "~> 7.0.8", ">= 7.0.8.7"
gem "puma", "~> 5.0"

# Dependencias del microservicio
gem "redis"
gem "stomp"

# Optimización de carga
gem "bootsnap", require: false

# Soporte de zona horaria para Windows
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
end
