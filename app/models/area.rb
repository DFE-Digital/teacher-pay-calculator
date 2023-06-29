class Area < BaseModel
  attr_accessor :id, :name

  def self.find(id)
    found = all_areas[id]
    return nil unless found

    new(id:, name: found)
  end

  def self.all_areas
    Rails.configuration.x.calculator.areas
  end
  private_class_method :all_areas
end
