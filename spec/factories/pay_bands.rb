FactoryBot.define do
  factory :pay_band do
    sequence(:id) {|i| :"pb#{i}" }

    name { FFaker::Lorem.words(rand(2..3)).join(' ').capitalize }
    type { %i[unqualified qualified leadership].sample }

    to_create do |struct|
      struct.class.store.add struct
    end
  end
end
