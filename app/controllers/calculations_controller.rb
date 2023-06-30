class CalculationsController < ApplicationController
  def new
    @calculation = Calculation.new
  end

  def results
    @calculation = Calculation.new(calculation_params)
    if @calculation.valid?
      render :results
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def calculation_params
    params.require(:calculation).permit(
      :area_id,
      :current_payband_or_spine_point_id
     )
  end
end
