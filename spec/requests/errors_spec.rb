require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /404' do
    before do
      get '/404'
    end

    it { expect(response).to have_http_status(:not_found) }
    it { expect(response.body).to include(I18n.t('error_pages.not_found')) }
  end

  describe 'GET /422' do
    before do
      get '/422'
    end

    it { expect(response).to have_http_status(:unprocessable_entity) }
    it { expect(response.body).to include(I18n.t('error_pages.unprocessable_entity')) }
  end

  describe 'GET /429' do
    before do
      get '/429'
    end

    it { expect(response).to have_http_status(:too_many_requests) }
    it { expect(response.body).to include(I18n.t('error_pages.too_many_requests')) }
  end

  describe 'GET /500' do
    before do
      get '/500'
    end

    it { expect(response).to have_http_status(:internal_server_error) }
    it { expect(response.body).to include(I18n.t('error_pages.internal_server_error')) }
  end
end
