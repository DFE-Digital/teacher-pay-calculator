SalaryFigures = Struct.new(
  :area,
  :pay_band,
  :type,
  :current,
  :first_year_future,
  :first_year_increase,
  :increase_percentage,
  :second_year_future,
  :second_year_increase,
  :second_year_increase_percentage,
  keyword_init: true
) do
  def range?
    type == :range
  end

  def first_year_increase_percentage
    increase_percentage
  end
end

class << SalaryFigures
  delegate :find, :all, to: :store

  def store
    @store ||= StructStore.new(self)
  end
end
