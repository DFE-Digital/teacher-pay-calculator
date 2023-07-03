Rails.application.routes.draw do
  root to: 'calculations#new', as: :new_calculation

  post 'results', to: 'calculations#results', as: :results
  get 'results', to: redirect('/')

  get '/healthcheck', to: proc { [200, {}, ['OK']] }

  scope via: :all do
    get '/404', to: 'errors#not_found'
    get '/422', to: 'errors#unprocessable_entity'
    get '/429', to: 'errors#too_many_requests'
    get '/500', to: 'errors#internal_server_error'
  end
end
