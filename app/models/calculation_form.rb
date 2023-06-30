class CalculationForm < Form
  attribute :area_id, :string
  attribute :pay_band_id, :string

  validates :pay_band_id, :area_id, presence: true

  validates :pay_band_id, inclusion: { in: proc { PayBand.pluck(:id, &:to_s) }, message: :invalid }
  validates :area_id, inclusion: { in: proc { Area.pluck(:id, &:to_s) }, message: :invalid }

  def area
    Area.find(id: area_id.to_sym)
  end

  def pay_band
    PayBand.find(id: pay_band_id.to_sym)
  end

  def salary_figure
    SalaryFigures.find(area:, pay_band:)
  end
end
