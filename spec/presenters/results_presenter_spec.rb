require 'rails_helper'

RSpec.describe ResultsPresenter, type: :view do
  describe '#primary_text' do
    subject { described_class.new(calculation:).primary_text }

    context 'when the results are for a spine point' do
      let(:calculation) { build(:calculation, :spine_point) }

      let(:expected_text) do
        I18n.t(
          'results.panel.spine_point_outcome.title',
          spine_point: calculation.current_payband_or_spine_point.name,
          value: number_to_currency(calculation.future_value, precision: 0)
        )
      end

      it { is_expected.to eq(expected_text) }
    end

    context 'when the results are for a payband' do
      let(:calculation) { build(:calculation, :payband) }

      let(:expected_text) do
        I18n.t(
          'results.panel.payband_outcome.title',
          payband: calculation.current_payband_or_spine_point.name,
          future_value_min: number_to_currency(calculation.future_value_min, precision: 0),
          future_value_max: number_to_currency(calculation.future_value_max, precision: 0)
        )
      end

      it { is_expected.to eq(expected_text) }
    end
  end

  describe '#secondary_text' do
    subject { described_class.new(calculation:).secondary_text }

    context 'when the results are for a spine point' do
      let(:calculation) { build(:calculation, :spine_point) }

      let(:expected_text) do
        I18n.t(
          'results.panel.spine_point_outcome.text',
          increase_value: number_to_currency(calculation.increase_value, precision: 0),
          increase_percentage: number_with_precision(calculation.increase_percentage, precision: 1)
        )
      end

      it { is_expected.to eq(expected_text) }
    end

    context 'when the results are for a payband' do
      let(:calculation) { build(:calculation, :payband) }

      let(:expected_text) do
        I18n.t(
          'results.panel.payband_outcome.text',
          increase_value_min: number_to_currency(calculation.increase_value_min, precision: 0),
          increase_percentage_min: number_with_precision(calculation.increase_percentage_min, precision: 1)
        )
      end

      it { is_expected.to eq(expected_text) }
    end
  end
end
