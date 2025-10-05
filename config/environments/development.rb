# config/environments/development.rb
Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  config.log_level = :debug
  config.logger = ActiveSupport::Logger.new($stdout)

  # API only
  config.action_controller.perform_caching = false
  config.public_file_server.enabled = true
end
