Area = Struct.new(:id, :name)

class << Area
  delegate :find, :all, :pluck, to: :store

  def store
    @store ||= StructStore.new(self)
  end
end
