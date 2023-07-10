class ApplicationController < ActionController::Base
  include HttpAuthConcern

  protect_from_forgery if: :production?

  default_form_builder(GOVUKDesignSystemFormBuilder::FormBuilder)

  protected

  def production?
    Rails.application.config.environment_name.production?
  end
end
