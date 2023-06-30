require 'rails_helper'

RSpec.describe 'Calculations', type: :request do
  describe 'GET /' do
    before do
      get '/'
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(response.body).to include('Calculate teacher pay') }
  end

  describe 'GET /results' do
    before do
      get '/results'
    end

    it { expect(response).to have_http_status(:redirect) }
    it { expect(response).to redirect_to('/') }
  end

  describe 'POST /results' do
    before do
      post '/results', params: { calculation: { **params } }
    end

    context 'with valid params' do
      let(:params) do
        {
          area_id: 'london_fringe',
          current_payband_or_spine_point_id: 'unq1'
        }
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(response.body).to include('Your answers') }
    end

    context 'with invalid params' do
      let(:params) do
        {
          area_id: 'invalid',
          current_payband_or_spine_point_id: 'unq1'
        }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(response.body).not_to include('Your answers') }
    end
  end
end
