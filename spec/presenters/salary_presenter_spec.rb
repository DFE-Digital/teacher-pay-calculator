RSpec.describe SalaryPresenter do
  include ActionView::Helpers::NumberHelper

  subject(:presenter) { described_class.new(salary_figures) }

  describe '#primary_text' do
    subject { presenter.primary_text }

    context 'when the results are for a spine point' do
      let(:salary_figures) { build :salary_figures, :value }

      let(:expected_text) do
        I18n.t('results.panel.spine_point_outcome.title',
          spine_point: salary_figures.pay_band.name,
          value: number_to_currency(salary_figures.first_year_future, precision: 0)
        )
      end

      it { is_expected.to eq(expected_text) }
    end

    context 'when the results are for a payband' do
      let(:salary_figures) { build :salary_figures, :range }

      let(:expected_text) do
        I18n.t('results.panel.pay_band_outcome.title',
          pay_band: salary_figures.pay_band.name,
          future_value_min: number_to_currency(salary_figures.first_year_future.min, precision: 0),
          future_value_max: number_to_currency(salary_figures.first_year_future.max, precision: 0)
        )
      end

      it { is_expected.to eq(expected_text) }
    end
  end

  describe '#secondary_text' do
    subject { presenter.secondary_text }

    context 'when the results are for a spine point' do
      let(:salary_figures) { build :salary_figures, :value }

      let(:expected_text) do
        [I18n.t('results.panel.spine_point_outcome.text',
          first_year_increase_value: number_to_currency(salary_figures.first_year_increase, precision: 0),
          first_year_increase_percentage: number_with_precision(
            salary_figures.first_year_increase_percentage,
            precision: 1,
            strip_insignificant_zeros: true
          )
        ),
        I18n.t('results.panel.spine_point_outcome.future_year',
          spine_point: salary_figures.pay_band.name,
          second_year_value: number_to_currency(salary_figures.second_year_future, precision: 0),
          second_year_increase_percentage: number_with_precision(
            salary_figures.second_year_increase_percentage,
            precision: 1,
            strip_insignificant_zeros: true
          )
        )].join("<hr class=\"govuk-section-break govuk-section-break--l\" />").html_safe
      end

      it { is_expected.to eq(expected_text) }
    end

    context 'when the results are for a pay band' do
      let(:salary_figures) { build :salary_figures, :range }

      let(:expected_text) do
        [I18n.t('results.panel.pay_band_outcome.text',
          increase_value_min: number_to_currency(salary_figures.first_year_increase.min, precision: 0),
          increase_percentage_min: number_with_precision(
            salary_figures.increase_percentage.min,
            precision: 1,
            strip_insignificant_zeros: true
          )
        ),
        I18n.t('results.panel.pay_band_outcome.future_year',
          second_year_value_min: number_to_currency(salary_figures.second_year_future.min, precision: 0),
          second_year_value_max: number_to_currency(salary_figures.second_year_future.max, precision: 0),
          second_year_increase_value_min: number_to_currency(salary_figures.second_year_increase.min, precision: 0),
          second_year_increase_value_max: number_to_currency(salary_figures.second_year_increase.max, precision: 0),
          second_year_increase_percentage_min: number_with_precision(
            salary_figures.second_year_increase_percentage.min,
            precision: 1,
            strip_insignificant_zeros: true
          )
        )].join("<hr class=\"govuk-section-break govuk-section-break--l\" />").html_safe
      end

      it { is_expected.to eq(expected_text) }
    end
  end
end
