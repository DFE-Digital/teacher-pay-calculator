class ApplicationController < ActionController::Base
  include HttpAuthConcern

  default_form_builder(GOVUKDesignSystemFormBuilder::FormBuilder)
end
