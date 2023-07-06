FactoryBot.define do
  factory :area do
    id { name.underscore.to_sym }
    name { FFaker::AddressUK.county }

    to_create do |struct|
      store = struct.class.store
      store.find(id: struct.id) || store.add(struct)
    end
  end
end
