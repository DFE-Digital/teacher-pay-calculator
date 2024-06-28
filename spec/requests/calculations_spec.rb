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
      post '/results', params: { calculation_form: { **params } }
    end

    context 'with valid params' do
      let(:salary_figures) { create :salary_figures }

      let(:params) do
        {
          area_id: salary_figures.area.id.to_s,
          pay_band_id: salary_figures.pay_band.id.to_s
        }
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(response.body).to include('Your answers') }
    end

    context 'with invalid params' do
      let(:params) do
        {
          area_id: 'invalid',
          pay_band_id: create(:pay_band).id.to_s
        }
      end

      it { expect(response).to have_http_status(:unprocessable_content) }
      it { expect(response.body).not_to include('Your answers') }
    end
  end
end
