SalaryFigures = Struct.new(:area, :pay_band, :type, :current, :future, :increase, :increase_percentage) do
  def range?
    type == :range
  end
end

class << SalaryFigures
  delegate :find, :all, to: :store

  def store
    @store ||= StructStore.new(self)
  end
end
