source 'https://rubygems.org'
git_source(:github) { |_repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'govuk-components'
gem 'govuk_design_system_formbuilder'
gem 'jsbundling-rails'
gem 'kramdown'
gem 'propshaft'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.5.1'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'slim-rails'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

group :development do
  gem 'prettier_print', require: false
  gem 'rubocop-govuk', require: false
  gem 'web-console'
end

group :test, :development do
  gem 'byebug'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec'
  gem 'rspec-rails'
end
