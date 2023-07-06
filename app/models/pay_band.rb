PayBand = Struct.new(:id, :name, :type)

class << PayBand
  delegate :find, :all, :pluck, to: :store

  def store
    @store ||= StructStore.new(self)
  end
end
