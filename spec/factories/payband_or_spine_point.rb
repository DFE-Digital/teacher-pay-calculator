FactoryBot.define do
  factory :payband_or_spine_point do
    spine_point

    trait :spine_point do
      id { 'unq1' }
      name { 'Unqualified Pay Range 1 (UnQ1)' }
      current_values { [18_000] }
      future_values { [19_500] }
    end

    trait :payband do
      id { 'leadership' }
      name { 'Leadership' }
      current_values { [50_000, 100_000] }
      future_values { [60_000, 120_000] }
    end
  end
end
