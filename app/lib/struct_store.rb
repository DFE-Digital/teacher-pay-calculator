class StructStore
  def initialize(struct_class)
    @struct_class = struct_class
  end

  def all
    @all ||= []
  end

  def pluck(attr, &block)
    result = all.map(&attr)
    result = result.map(&block) if block
    result
  end

  def add(struct)
    raise ArgumentError unless struct.is_a? @struct_class
    all << struct
    self
  end

  def find(**args)
    all.find { |str| str.to_h.values_at(*args.keys) == args.values }
  end

  def clear!
    all.clear
  end
end
