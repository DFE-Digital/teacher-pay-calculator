require 'rails_helper'

RSpec.describe 'Inactive service', type: :request do
  before do
    allow(Rails.application.config.x).to receive(:inactive_service)
      .and_return(inactive_service?)
    Rails.application.reload_routes!
    get '/'
  end

  context 'when the service is inactive' do
    let(:inactive_service?) { true }

    it { expect(response).to have_http_status(:success) }
    it { expect(response.body).to include('This service is not currently available') }
  end

  context 'when the service is not inactive' do
    let(:inactive_service?) { false }

    it { expect(response).to have_http_status(:success) }
    it { expect(response.body).to include('Calculate teacher pay following the 2023 pay award') }
  end
end
