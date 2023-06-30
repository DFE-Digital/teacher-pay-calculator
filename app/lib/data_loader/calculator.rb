class DataLoader::Calculator
  def self.call(current:, future:)
    raise ArgumentError if current.length > 2 || current.length != future.length

    if current.one?
      SpinePoint.new(current: current.first, future: future.first).call
    else
      PayBand.new(current: Range.new(*current), future: Range.new(*future)).call
    end
  end

  class Base
    attr_reader :current, :future

    def initialize(current:, future:)
      @current = current
      @future = future
    end

    def call
      {
        type: type,
        current: current,
        future: future,
        increase: increase,
        increase_percentage: increase_percentage
      }
    end
  end

  class SpinePoint < Base
    def type
      :value
    end

    def increase
      future - current
    end

    def increase_percentage
      (increase.to_f / current * 100).round(1)
    end
  end

  class PayBand < Base
    def type
      :range
    end

    def increase
      calc_change { |current, future| future - current }
    end

    def increase_percentage
      calc_change { |current, future| ((future - current).to_f / current * 100).round(1) }
    end

    private

    def calc_change
      values = [
        yield(current.min, future.min),
        yield(current.max, future.max)
      ]

      Range.new(*values.sort)
    end
  end
end
