class SalaryPresenter
  include ActionView::Helpers::NumberHelper

  attr_reader :salary_figures
  delegate :area, :pay_band, to: :salary_figures

  def initialize(salary_figures)
    @salary_figures = salary_figures
  end

  def primary_text
    salary_figures.range? ? payband_primary_text : spine_point_primary_text
  end

  def secondary_text
    salary_figures.range? ? payband_secondary_text : spine_point_secondary_text
  end

  private

  def spine_point_primary_text
    I18n.t('results.panel.spine_point_outcome.title',
      spine_point: pay_band.name,
      value: number_to_currency(salary_figures.future, precision: 0)
    )
  end

  def spine_point_secondary_text
    I18n.t('results.panel.spine_point_outcome.text',
      increase_value: number_to_currency(salary_figures.increase, precision: 0),
      increase_percentage: number_with_precision(
        salary_figures.increase_percentage,
        precision: 1,
        strip_insignificant_zeros: true
      )
    )
  end

  def payband_primary_text
    I18n.t('results.panel.pay_band_outcome.title',
      pay_band: pay_band.name,
      future_value_min: number_to_currency(salary_figures.future.min, precision: 0),
      future_value_max: number_to_currency(salary_figures.future.max, precision: 0)
    )
  end

  def payband_secondary_text
    I18n.t('results.panel.pay_band_outcome.text',
      increase_value_min: number_to_currency(salary_figures.increase.min, precision: 0),
      increase_percentage_min: number_with_precision(
        salary_figures.increase_percentage.min,
        precision: 1,
        strip_insignificant_zeros: true
      )
    )
  end
end
