class CalculationsController < ApplicationController
  def new
  end

  def results
    form.assign_attributes(calculation_params)

    if form.valid?
      @presenter = SalaryPresenter.new(form.salary_figure)
      render :results
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def calculation_params
    params.require(:calculation_form).permit(:area_id, :pay_band_id)
  end

  def form
    @form ||= CalculationForm.new
  end
  helper_method :form
end
