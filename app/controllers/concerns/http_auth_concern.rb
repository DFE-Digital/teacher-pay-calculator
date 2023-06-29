module HttpAuthConcern
  extend ActiveSupport::Concern

  included do
    if ENV["HTTP_USERNAME"].present? && ENV["HTTP_PASSWORD"].present?
      http_basic_authenticate_with(
        name: ENV.fetch("HTTP_USERNAME"),
        password: ENV.fetch("HTTP_PASSWORD")
      )
    end
  end
end
