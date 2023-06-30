require 'rails_helper'

RSpec.describe Area, type: :model do
  describe '.find' do
    let(:existing_area) { create :area }
    subject { described_class.find(id:) }

    context 'with invalid area_id' do
      let(:id) { 'invalid' }

      it { is_expected.to be_nil }
    end

    context 'with valid area_id' do
      let(:id) { existing_area.id }

      it { is_expected.to be_a(described_class) }
      it { is_expected.to have_attributes(id:) }
    end
  end
end
