module CalculationsHelper
  Option = Struct.new(:id, :name)

  NO_OPTION = { id: 'no_option', name: I18n.t('questions.no_option.label') }.freeze
  private_constant :NO_OPTION

  def paybands_and_spine_points_options
    build_options(available_paybands_and_spine_points)
  end

  def paybands_and_spine_points_including_no_option
    [Option.new(**NO_OPTION)] + paybands_and_spine_points_options
  end

  def area_options_london
    area_options.select { |opt| opt.id.include?('london') }
  end

  def area_option_rest_of_england
    area_options.find { |opt| opt.id.end_with?('england') }
  end

  private

  def available_paybands_and_spine_points
    Rails.configuration.x.calculator.paybands_and_spine_points.values.inject(:merge)
  end

  def available_areas
    Rails.configuration.x.calculator.areas
  end

  def area_options
    build_options(available_areas)
  end

  def build_options(hash)
    hash.map { |attrs| Option.new(*attrs) }
  end
end
