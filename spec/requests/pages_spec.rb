require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET /privacy-notice' do
    before do
      get '/privacy-notice'
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(response.body).to include('Privacy notice') }
  end

  describe 'GET /accessibility-statement' do
    before do
      get '/accessibility-statement'
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(response.body).to include('Accessibility statement') }
  end

  describe 'GET /terms-and-conditions' do
    before do
      get '/terms-and-conditions'
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(response.body).to include('Terms and conditions') }
  end
end
