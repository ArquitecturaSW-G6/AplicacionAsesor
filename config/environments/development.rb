require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  # 🚫 ActiveRecord no está habilitado
  # config.active_record.migration_error = :page_load
  # config.active_record.verbose_query_logs = true

  # File watcher
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
end