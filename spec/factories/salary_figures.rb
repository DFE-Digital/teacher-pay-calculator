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

    increase do
      if type == :value
        (current * increase_percentage / 100).to_i
      else
        bounds = current.minmax.zip(increase_percentage.minmax.shuffle)
          .map { |current, percent| (current * percent / 100).to_i }
        Range.new(*bounds.sort)
      end
    end

    future do
      if type == :value
        current + increase
      else
        Range.new(current.min + increase.min, current.max + increase.max)
      end
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
