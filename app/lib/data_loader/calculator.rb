class DataLoader::Calculator
  def self.call(current:, first_year_future:, second_year_future: nil)
    raise ArgumentError if second_year_future && second_year_future.length != current.length

    raise ArgumentError if current.length > 2 || current.length != first_year_future.length

    if current.one?
      SpinePoint.new(
        current: current.first,
        first_year_future: first_year_future.first,
        second_year_future: second_year_future&.first
      ).call
    else
      PayBand.new(
        current: Range.new(*current),
        first_year_future: Range.new(*first_year_future),
        second_year_future: second_year_future && Range.new(*second_year_future)
      ).call
    end
  end

  class Base
    attr_reader :current, :first_year_future, :provided_second_year_future

    def initialize(current:, first_year_future:, second_year_future: nil)
      @current = current
      @first_year_future = first_year_future
      @provided_second_year_future = second_year_future
    end

    def call
      {
        type:,
        current:,
        first_year_future:,
        first_year_increase:,
        second_year_future:,
        second_year_increase:,
        second_year_increase_percentage:,
        increase_percentage:
      }
    end
  end

  class SpinePoint < Base
    def type
      :value
    end

    def first_year_increase
      first_year_future - current
    end

    def second_year_increase
      second_year_future - first_year_future
    end

    def second_year_future
      return provided_second_year_future if provided_second_year_future

      first_year_future + (first_year_future * first_year_increase_percentage / 100).to_i
    end

    def first_year_increase_percentage
      (first_year_increase.to_f / current * 100).round(1)
    end

    def second_year_increase_percentage
      (second_year_increase.to_f / first_year_future * 100).round(1)
    end

    def increase_percentage
      first_year_increase_percentage
    end
  end

  class PayBand < Base
    def type
      :range
    end

    def first_year_increase
      calc_change { |current, first_year_future| first_year_future - current }
    end

    def second_year_increase
      if provided_second_year_future
        values = [
          second_year_future.min - first_year_future.min,
          second_year_future.max - first_year_future.max
        ]

        return Range.new(*values.sort)
      end

      calc_second_year_change do |first_year_future, increase_percentage|
        (first_year_future * increase_percentage / 100).to_i
      end
    end

    def second_year_future
      return provided_second_year_future if provided_second_year_future

      Range.new(
        first_year_future.min + second_year_increase.min,
        first_year_future.max + second_year_increase.max
      )
    end

    def second_year_increase_percentage
      values = [
        calculate_percentage_increase(second_year_increase_for(first_year_future.min), first_year_future.min),
        calculate_percentage_increase(second_year_increase_for(first_year_future.max), first_year_future.max)
      ]

      Range.new(*values.sort)
    end

    private

    def calculate_percentage_increase(change, base)
      (change.to_f / base * 100).round(1)
    end

    def increase_percentage
      calc_change { |current, first_year_future| ((first_year_future - current).to_f / current * 100).round(1) }
    end

    def calc_change
      values = [
        yield(current.min, first_year_future.min),
        yield(current.max, first_year_future.max)
      ]

      Range.new(*values.sort)
    end

    def calc_second_year_change
      values = [
        yield(first_year_future.min, increase_percentage.min),
        yield(first_year_future.max, increase_percentage.max)
      ]

      Range.new(*values.sort)
    end

    def second_year_increase_for(first_year_future_value)
      if provided_second_year_future
        second_year_future_value =
          if first_year_future_value == first_year_future.min
            second_year_future.min
          else
            second_year_future.max
          end
        second_year_future_value - first_year_future_value
      else
        increase_pct =
          if first_year_future_value == first_year_future.min
            increase_percentage.min
          else
            increase_percentage.max
          end
        (first_year_future_value * increase_pct / 100).to_i
      end
    end
  end
end
