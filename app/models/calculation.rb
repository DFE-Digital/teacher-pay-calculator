class Calculation < BaseModel
  attr_accessor :area_id, :current_payband_or_spine_point_id

  delegate :spine_point?, :payband?,
    :current_value, :current_value_min, :current_value_max,
    :future_value, :future_value_min, :future_value_max,
    to: :current_payband_or_spine_point

  validate :current_payband_or_spine_point_must_be_selected
  validate :current_payband_or_spine_point_must_be_valid, if: :valid_area?
  validate :area_must_be_valid

  def valid?
    return false unless super
    return true if current_payband_or_spine_point&.valid? && area&.valid?

    errors.add(:base, :invalid) # This should probably be logged
    false
  end

  def increase_value
    future_value - current_value
  end
  alias_method :increase_value_min, :increase_value

  def increase_percentage
    return 0 if increase_value.zero?

    (increase_value / current_value.to_d * 100).truncate(2).to_f
  end
  alias_method :increase_percentage_min, :increase_percentage

  def current_payband_or_spine_point
    @current_payband_or_spine_point ||=
      PaybandOrSpinePoint.find(current_payband_or_spine_point_id, area_id)
  end

  def area
    @area ||= Area.find(area_id)
  end

  private

  def area_must_be_valid
    errors.add(:area_id, :invalid) unless valid_area?
  end

  def current_payband_or_spine_point_must_be_selected
    return if current_payband_or_spine_point_id.present? && !no_option?

    errors.add(:current_payband_or_spine_point_id, :invalid)
  end

  def current_payband_or_spine_point_must_be_valid
    return if current_payband_or_spine_point

    errors.add(:current_payband_or_spine_point_id, :invalid)
  end

  def valid_area?
    area.present?
  end

  def no_option?
    current_payband_or_spine_point_id.to_sym == :no_option
  end
end
