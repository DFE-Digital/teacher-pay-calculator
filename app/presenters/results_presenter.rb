class ResultsPresenter
  include ActionView::Helpers::NumberHelper

  ResultsError = Class.new(StandardError)

  delegate :area, :current_payband_or_spine_point, to: :calculation

  def initialize(calculation:)
    @calculation = calculation
  end

  def primary_text
    return spine_point_primary_text if calculation.spine_point?
    return payband_primary_text if calculation.payband?

    raise ResultsError
  end

  def secondary_text
    return spine_point_secondary_text if calculation.spine_point?
    return payband_secondary_text if calculation.payband?

    raise ResultsError
  end

  private

  attr_reader :calculation

  def spine_point_primary_text
    I18n.t(
      'results.panel.spine_point_outcome.title',
      spine_point: current_payband_or_spine_point.name,
      value: number_to_currency(calculation.future_value, precision: 0)
    )
  end

  def spine_point_secondary_text
    I18n.t(
      'results.panel.spine_point_outcome.text',
      increase_value: number_to_currency(calculation.increase_value, precision: 0),
      increase_percentage: number_with_precision(calculation.increase_percentage, precision: 1)
    )
  end

  def payband_primary_text
    I18n.t(
      'results.panel.payband_outcome.title',
      payband: current_payband_or_spine_point.name,
      future_value_min: number_to_currency(calculation.future_value_min, precision: 0),
      future_value_max: number_to_currency(calculation.future_value_max, precision: 0)
    )
  end

  def payband_secondary_text
    I18n.t(
      'results.panel.payband_outcome.text',
      increase_value_min: number_to_currency(calculation.increase_value_min, precision: 0),
      increase_percentage_min: number_with_precision(calculation.increase_percentage_min, precision: 1)
    )
  end
end
