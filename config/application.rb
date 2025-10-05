# config/application.rb
require_relative "boot"

require "rails"
require "active_model/railtie"
# ❌ Nada que toque base de datos ni sus dependientes
# require "active_job/railtie"
# require "active_record/railtie"
# require "active_storage/engine"
# require "action_mailbox/engine"
# require "action_text/engine"
# Componentes mínimos para API:
require "action_controller/railtie"
# (Mail/View/Cable no son necesarios; si no los usas, no los cargues)
# require "action_mailer/railtie"
# require "action_view/railtie"
# require "action_cable/engine"

Bundler.require(*Rails.groups)

module ServicioAsesor
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true

    # Generadores sin ORM
    config.generators do |g|
      g.orm :null
      g.test_framework nil
      g.helper false
      g.assets false
    end

    # Blindaje: si algún railtie mira config.active_record, que exista y sea inofensivo
    config.before_configuration do |app|
      app.config.active_record = ActiveSupport::OrderedOptions.new
      app.config.active_record.query_log_tags_enabled = false
      app.config.active_record.verbose_query_logs     = false
    end

    # Quitar middlewares de ActiveRecord si los hubiera
    initializer :strip_ar_middleware, before: :load_config_initializers do |app|
      %w[
        ActiveRecord::Migration::CheckPending
        ActiveRecord::ConnectionAdapters::ConnectionManagement
        ActiveRecord::QueryCache
      ].each do |mw|
        begin
          app.config.middleware.delete mw.constantize
        rescue
          # si no existe, seguimos
        end
      end
    end
  end
end
