require 'rails_helper'

RSpec.describe Calculation, type: :model do
  describe '#valid?' do
    subject(:valid?) { calculation.valid? }

    context 'when validating the current payband or spine point' do
      let(:calculation) { build(:calculation, current_payband_or_spine_point_id:) }

      context 'when the payband or spine point is not selected' do
        let(:current_payband_or_spine_point_id) { nil }

        it { is_expected.to eq(false) }
        it 'sets an error' do
          valid?
          expect(calculation.errors.first.type).to eq(:invalid)
        end
      end

      context 'when the payband or spine point is invalid' do
        let(:current_payband_or_spine_point_id) { 'invalid' }

        it { is_expected.to eq(false) }
        it 'sets an error' do
          valid?
          expect(calculation.errors.first.type).to eq(:invalid)
        end
      end

      context 'when the payband or spine point is valid' do
        let(:current_payband_or_spine_point_id) { 'unq1' }

        it { is_expected.to eq(true) }
      end
    end

    context 'when validating the area' do
      let(:calculation) { build(:calculation, area_id:) }

      context 'when the area is not selected' do
        let(:area_id) { nil }

        it { is_expected.to eq(false) }
        it 'sets an error' do
          valid?
          expect(calculation.errors.first.type).to eq(:invalid)
        end
      end

      context 'when the area is invalid' do
        let(:area_id) { 'invalid' }

        it { is_expected.to eq(false) }
        it 'sets an error' do
          valid?
          expect(calculation.errors.first.type).to eq(:invalid)
        end
      end

      context 'when the area is valid' do
        let(:area_id) { 'london_fringe' }

        it { is_expected.to eq(true) }
      end
    end
  end

  describe '#increase_value' do
    subject { calculation.increase_value }

    let(:mock) { build(:payband_or_spine_point, current_values:, future_values:) }

    let(:current_values) { [10_000] }
    let(:future_values) { [11_500] }

    before do
      allow(PaybandOrSpinePoint).to receive(:find).and_return(mock)
    end

    let(:calculation) { build(:calculation) }

    it { is_expected.to eq(1_500) }
  end

  describe '#increase_value_min' do
    subject { calculation.increase_value_min }

    let(:mock) { build(:payband_or_spine_point, current_values:, future_values:) }

    let(:current_values) { [10_000, 11_000] }
    let(:future_values) { [11_500, 12_000] }

    before do
      allow(PaybandOrSpinePoint).to receive(:find).and_return(mock)
    end

    let(:calculation) { build(:calculation) }

    it { is_expected.to eq(1_500) }
  end

  describe '#increase_percentage' do
    subject { calculation.increase_percentage }

    let(:mock) { build(:payband_or_spine_point, current_values:, future_values:) }

    let(:current_values) { [30_000] }
    let(:future_values) { [31_000] }

    before do
      allow(PaybandOrSpinePoint).to receive(:find).and_return(mock)
    end

    let(:calculation) { build(:calculation) }

    it { is_expected.to eq(3.33) }
  end

  describe '#increase_percentage' do
    subject { calculation.increase_percentage_min }

    let(:mock) { build(:payband_or_spine_point, current_values:, future_values:) }

    let(:current_values) { [30_000, 31_000] }
    let(:future_values) { [31_000, 32_000] }

    before do
      allow(PaybandOrSpinePoint).to receive(:find).and_return(mock)
    end

    let(:calculation) { build(:calculation) }

    it { is_expected.to eq(3.33) }
  end
end
