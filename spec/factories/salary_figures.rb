FactoryBot.define do
  factory :salary_figures do
    area
    pay_band

    type { %i[range value].sample }

    current do
      if type == :value
        rand(20_000..50_000)
      else
        lower = rand(20_000..50_000)
        upper = lower + rand(10_000..30_000)
        lower..upper
      end
    end

    increase_percentage do
      if type == :value
        rand(3.0..6.0).round(1)
      else
        Range.new(*Array.new(2) { rand(3.0..6.0).round(1)}.sort)
      end
    end

    first_year_increase do
      if type == :value
        (current * increase_percentage / 100).to_i
      else
        bounds = current.minmax.zip(increase_percentage.minmax.shuffle)
          .map { |current, percent| (current * percent / 100).to_i }
        Range.new(*bounds.sort)
      end
    end

    first_year_future do
      if type == :value
        current + first_year_increase
      else
        Range.new(current.min + first_year_increase.min, current.max + first_year_increase.max)
      end
    end

    second_year_future do
      if type == :value
        first_year_future + second_year_increase
      else
        Range.new(first_year_future.min + second_year_increase.min, first_year_future.max + second_year_increase.max)
      end
    end

    second_year_increase do
      if type == :value
        (first_year_future * increase_percentage / 100).to_i
      else
        Range.new(
          (first_year_future.min * increase_percentage.min / 100).to_i,
          (first_year_future.max * increase_percentage.max / 100).to_i
        )
      end
    end

    second_year_increase_percentage do
      increase_percentage
    end

    trait :value do
      type { :value }
    end

    trait :range do
      type { :range }
    end

    to_create do |struct|
      struct.class.store.add struct
    end
  end
end
