Sentry.init do |config|
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.environment = Rails.application.config.environment_name
  config.traces_sample_rate = 0.2
end
