class ApplicationController < ActionController::Base
  include HttpAuthConcern

  skip_forgery_protection

  default_form_builder(GOVUKDesignSystemFormBuilder::FormBuilder)
end
