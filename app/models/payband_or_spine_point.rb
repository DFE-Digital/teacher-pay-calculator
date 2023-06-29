class PaybandOrSpinePoint < BaseModel
  attr_accessor :id, :name, :current_values, :future_values

  validate :current_values_must_be_valid
  validate :future_values_must_be_valid
  validate :future_values_must_be_increasing, if: :valid_future_values?

  def self.find(id, area_id)
    found = ranges.dig(id, area_id)
    return nil unless found

    new(id:, name: names[id], current_values: found[:current], future_values: found[:future])
  end

  def spine_point?
    current_values.size == 1
  end

  def payband?
    !spine_point?
  end

  def current_value
    current_values.first
  end
  alias_method :current_value_min, :current_value

  def future_value
    future_values.first
  end
  alias_method :future_value_min, :future_value

  def current_value_max
    current_values.last
  end

  def future_value_max
    future_values.last
  end

  def self.paybands_and_spine_points
    Rails.configuration.x.calculator.paybands_and_spine_points
  end
  private_class_method :paybands_and_spine_points

  def self.ranges
    Rails.configuration.x.calculator.pay_ranges
  end
  private_class_method :ranges

  def self.names
    paybands_and_spine_points.values.inject(:merge)
  end
  private_class_method :names

  private

  def current_values_must_be_valid
    return if valid_values?(current_values)

    errors.add(:current_values, :invalid)
  end

  def future_values_must_be_valid
    return if valid_future_values?

    errors.add(:future_values, :invalid)
  end

  def future_values_must_be_increasing
    return if future_values.zip(current_values).all? { |v| v.first > v.last }

    errors.add(:future_values, :not_increasing)
  end

  def valid_values?(array)
    return false if array.blank?

    array.size.between?(1,2)
  end

  def valid_future_values?
    valid_values?(future_values) && future_values.size == current_values.size
  end
end
