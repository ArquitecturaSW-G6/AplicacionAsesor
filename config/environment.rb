# config/environment.rb
require_relative "application"

# Asegurar que nadie intente cargar AR
module ActiveRecord; end

Rails.application.initialize!
