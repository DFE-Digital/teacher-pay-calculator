RSpec.feature 'Teacher Pay Calculator' do
  include ActionView::Helpers::NumberHelper

  let!(:areas) { FactoryBot.create_list :area, rand(2..4) }
  let!(:pay_bands) { FactoryBot.create_list :pay_band, rand(3..5) }

  let(:area) { areas.sample }
  let(:pay_band) { pay_bands.sample }

  scenario "displaying the form" do
    visit ''

    expect(page).to have_content t('questions.heading')
    expect(page).to have_select t('questions.current_pay_band.label'),
      options: [t('questions.no_option.label')] + pay_bands.map(&:name),
      selected: []

    areas.each { |area| find :radio_button, area.name }
  end

  scenario "selecting spine point figures" do
    salary_figures = FactoryBot.create(:salary_figures, :value, area:, pay_band:)

    visit ''

    select pay_band.name, from: t('questions.current_pay_band.label')
    choose area.name

    click_on t(".questions.submit.label")

    expect(page)
      .to have_content(t('results.panel.spine_point_outcome.title',
        spine_point: pay_band.name,
        value: number_to_currency(salary_figures.first_year_future, precision: 0)
      )).and have_content(t('results.panel.spine_point_outcome.text',
        first_year_increase_value: number_to_currency(salary_figures.first_year_increase, precision: 0),
        first_year_increase_percentage: number_with_precision(
          salary_figures.first_year_increase_percentage,
          precision: 1,
          strip_insignificant_zeros: true
        )
      )).and have_content(t('results.panel.spine_point_outcome.future_year',
        spine_point: pay_band.name,
        second_year_value: number_to_currency(salary_figures.second_year_future, precision: 0),
        second_year_increase_percentage: number_with_precision(
          salary_figures.second_year_increase_percentage,
          precision: 1,
          strip_insignificant_zeros: true
        )
      ))
  end

  scenario "selecting pay band figures" do
    salary_figures = FactoryBot.create(:salary_figures, :range, area:, pay_band:)

    visit ''

    select pay_band.name, from: t('questions.current_pay_band.label')
    choose area.name

    click_on t(".questions.submit.label")

    expect(page)
      .to have_content(t('results.panel.pay_band_outcome.title',
        pay_band: pay_band.name,
        future_value_min: number_to_currency(salary_figures.first_year_future.min, precision: 0),
        future_value_max: number_to_currency(salary_figures.first_year_future.max, precision: 0)
     )).and have_content(t('results.panel.pay_band_outcome.text',
        increase_value_min: number_to_currency(salary_figures.first_year_increase.min, precision: 0),
        increase_percentage_min: number_with_precision(
          salary_figures.increase_percentage.min,
          precision: 1,
          strip_insignificant_zeros: true
        )
     )).and have_content(t('results.panel.pay_band_outcome.future_year',
        second_year_value_min: number_to_currency(salary_figures.second_year_future.min, precision: 0),
        second_year_increase_value_min: number_to_currency(salary_figures.second_year_increase.min, precision: 0),
        second_year_increase_value_max: number_to_currency(salary_figures.second_year_increase.max, precision: 0),
        second_year_increase_percentage_min: number_with_precision(
          salary_figures.second_year_increase_percentage.min,
          precision: 1,
          strip_insignificant_zeros: true
        )
     ))
  end

  delegate :t, to: I18n
end
