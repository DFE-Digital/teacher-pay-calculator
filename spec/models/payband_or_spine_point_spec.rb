require 'rails_helper'

RSpec.describe PaybandOrSpinePoint, type: :model do
  describe '#valid?' do
    subject(:valid?) { payband_or_spine_point.valid? }

    let(:payband_or_spine_point) do
      build(:payband_or_spine_point, current_values:, future_values:)
    end

    context 'when validating a spine point' do
      let(:current_values) { [9_000] }
      let(:future_values) { [10_000] }

      context 'when there is one and only one future value' do
        it { is_expected.to eq(true) }
      end

      context 'when there are more than one future values' do
        let(:future_values) { [10_000, 11_000] }

        it { is_expected.to eq(false) }
        it 'sets an error ' do
          valid?
          expect(payband_or_spine_point.errors.first.type).to eq(:invalid)
        end
      end

      context 'when there are no future values' do
        let(:future_values) { [] }

        it { is_expected.to eq(false) }
        it 'sets an error ' do
          valid?
          expect(payband_or_spine_point.errors.first.type).to eq(:invalid)
        end
      end

      context 'when the future value is the same as the current' do
        let(:current_values) { [9_000] }
        let(:future_values) { [9_000] }

        it { is_expected.to eq(false) }
        it 'sets an error ' do
          valid?
          expect(payband_or_spine_point.errors.first.type).to eq(:not_increasing)
        end
      end

      context 'when the future value is lower than the current' do
        let(:current_values) { [9_000] }
        let(:future_values) { [8_999] }

        it { is_expected.to eq(false) }
        it 'sets an error ' do
          valid?
          expect(payband_or_spine_point.errors.first.type).to eq(:not_increasing)
        end
      end

      context 'when the future value is greater than the current' do
        let(:current_values) { [9_000] }
        let(:future_values) { [9_001] }

        it { is_expected.to eq(true) }
      end
    end

    context 'when validating a payband' do
      let(:current_values) { [9_000, 10_000] }
      let(:future_values) { [11_000, 12_000] }

      context 'when there are two future values' do
        it { is_expected.to eq(true) }
      end

      context 'when there is one and only one future value' do
        let(:future_values) { [11_000] }

        it { is_expected.to eq(false) }
        it 'sets an error ' do
          valid?
          expect(payband_or_spine_point.errors.first.type).to eq(:invalid)
        end
      end

      context 'when there are more than two future values' do
        let(:future_values) { [10_000, 11_000, 12_000] }

        it { is_expected.to eq(false) }
        it 'sets an error ' do
          valid?
          expect(payband_or_spine_point.errors.first.type).to eq(:invalid)
        end
      end

      context 'when there are no future values' do
        let(:future_values) { [] }

        it { is_expected.to eq(false) }
        it 'sets an error ' do
          valid?
          expect(payband_or_spine_point.errors.first.type).to eq(:invalid)
        end
      end

      context 'when one of the future values is the same as the current' do
        let(:current_values) { [9_000, 10_000] }
        let(:future_values) { [9_000, 11_000] }

        it { is_expected.to eq(false) }
        it 'sets an error ' do
          valid?
          expect(payband_or_spine_point.errors.first.type).to eq(:not_increasing)
        end
      end

      context 'when one of the future values is lower than the current' do
        let(:current_values) { [9_000, 10_000] }
        let(:future_values) { [8_999, 11_000] }

        it { is_expected.to eq(false) }
        it 'sets an error ' do
          valid?
          expect(payband_or_spine_point.errors.first.type).to eq(:not_increasing)
        end
      end

      context 'when both the future values are greater than the current' do
        let(:current_values) { [9_000, 10_000] }
        let(:future_values) { [10_000, 11_000] }

        it { is_expected.to eq(true) }
      end
    end
  end

  describe '.find' do
    subject { described_class.find(id, area_id) }

    let(:id) { 'unq1' }
    let(:area_id) { 'london_fringe' }

    context 'when the payband or spine point does not exist' do
      context 'with invalid id' do
        let(:id) { 'invalid' }

        it { is_expected.to be_nil }
      end

      context 'with invalid area' do
        let(:area_id) { 'invalid' }

        it { is_expected.to be_nil }
      end
    end

    context 'when the payband or spine point exists' do
      it { is_expected.to be_a(described_class) }
      it { is_expected.to have_attributes(id:) }
    end
  end

  describe '#spine_point?' do
    subject { payband_or_spine_point.spine_point? }

    context 'when in presence of one salary value' do
      let(:payband_or_spine_point) { build(:payband_or_spine_point, :spine_point) }

      it { is_expected.to eq(true) }
    end

    context 'when in presence of more than one salary value' do
      let(:payband_or_spine_point) { build(:payband_or_spine_point, :payband) }

      it { is_expected.to eq(false) }
    end
  end

  describe '#payband?' do
    subject { payband_or_spine_point.payband? }

    context 'when in presence of one salary value' do
      let(:payband_or_spine_point) { build(:payband_or_spine_point, :spine_point) }

      it { is_expected.to eq(false) }
    end

    context 'when in presence of more than one salary value' do
      let(:payband_or_spine_point) { build(:payband_or_spine_point, :payband) }

      it { is_expected.to eq(true) }
    end
  end

  describe '#current_value' do
    subject { payband_or_spine_point.current_value }

    let(:payband_or_spine_point) { build(:payband_or_spine_point, current_values: [10_000, 12_000]) }

    it 'returns the first current value' do
      is_expected.to eq(10_000)
    end
  end

  describe '#current_value_min' do
    subject { payband_or_spine_point.current_value_min }

    let(:payband_or_spine_point) { build(:payband_or_spine_point, current_values: [10_000, 12_000]) }

    it 'returns the first current value' do
      is_expected.to eq(10_000)
    end
  end

  describe '#future_value' do
    subject { payband_or_spine_point.future_value }

    let(:payband_or_spine_point) { build(:payband_or_spine_point, future_values: [11_000, 13_000]) }

    it 'returns the first future value' do
      is_expected.to eq(11_000)
    end
  end

  describe '#future_value_min' do
    subject { payband_or_spine_point.future_value_min }

    let(:payband_or_spine_point) { build(:payband_or_spine_point, future_values: [11_000, 13_000]) }

    it 'returns the first future value' do
      is_expected.to eq(11_000)
    end
  end

  describe '#future_value_max' do
    subject { payband_or_spine_point.future_value_max }

    let(:payband_or_spine_point) { build(:payband_or_spine_point, future_values: [11_000, 13_000]) }

    it 'returns the second future value' do
      is_expected.to eq(13_000)
    end
  end
end
