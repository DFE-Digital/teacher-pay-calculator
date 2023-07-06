require 'rails_helper'

RSpec.describe PayBand, type: :model do
  describe '.find' do
    let(:existing_pay_band) { create :pay_band }
    subject { described_class.find(id:) }

    context 'with invalid id' do
      let(:id) { 'invalid' }

      it { is_expected.to be_nil }
    end

    context 'with valid id' do
      let(:id) { existing_pay_band.id }

      it { is_expected.to be_a(described_class) }
      it { is_expected.to have_attributes(id:) }
    end
  end
end
