require_relative "boot"

require "rails"
# ✅ Cargamos solo lo necesario (sin ActiveRecord ni bases de datos)
require "action_controller/railtie"
require "action_view/railtie"
require "active_model/railtie"
require "action_mailer/railtie"
require "action_cable/engine"
require "sprockets/railtie" if defined?(Sprockets)

Bundler.require(*Rails.groups)

module ServicioAsesor
  class Application < Rails::Application
    config.load_defaults 6.1

    # 🚫 Desactivar completamente ActiveRecord
    config.generators do |g|
      g.orm :null
    end

    # Solo modo API
    config.api_only = true

    # ✅ Permitir CORS (por ejemplo, para Android u otros servicios)
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end
  end
end