Sentry.init do |config|
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.environment = ENV.fetch('ENVIRONMENT_NAME', 'local')
  config.traces_sample_rate = 0.2
end
