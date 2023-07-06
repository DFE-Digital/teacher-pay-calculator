class DataLoader
  def load_areas
    Area.store.clear!
    source[:areas].each { |id, name| Area.store.add Area.new(id: id.to_sym, name:) }

    true
  end

  def load_pay_bands
    PayBand.store.clear!
    source[:paybands_and_spine_points].each do |type, group|
      group.each { |id, name| PayBand.store.add PayBand.new(id: id.to_sym, name:, type: type.to_sym) }
    end

    true
  end

  def load_salary_figures
    SalaryFigures.store.clear!
    source[:pay_ranges].each do |pay_band_id, group|
      group.each do |area_id, figures|
        calculated_figures = Calculator.call(**figures.symbolize_keys)
        SalaryFigures.store.add SalaryFigures.new(
          pay_band: PayBand.find(id: pay_band_id.to_sym),
          area: Area.find(id: area_id.to_sym),
          **calculated_figures
        )
      end
    end

    true
  end

  def load_all!
    load_areas
    load_pay_bands
    load_salary_figures
  end

  private

  def source
    @source ||= Rails.application.config_for(:calculator)
  end
end
