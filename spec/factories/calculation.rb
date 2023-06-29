FactoryBot.define do
  factory :calculation do
    spine_point

    trait :spine_point do
      area_id { 'london_fringe' }
      current_payband_or_spine_point_id { 'unq1' }
    end

    trait :payband do
      area_id { 'rest_of_england' }
      current_payband_or_spine_point_id { 'leading_practitioner' }
    end
  end
end
