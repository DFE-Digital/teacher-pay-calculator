Rails.application.config_for(:calculator).tap do |config|
  Rails.configuration.x.calculator.paybands_and_spine_points =
                                                config[:paybands_and_spine_points].with_indifferent_access
  Rails.configuration.x.calculator.areas      = config[:areas].with_indifferent_access
  Rails.configuration.x.calculator.pay_ranges = config[:pay_ranges].with_indifferent_access
end
