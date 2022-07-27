FactoryBot.define do
  factory :order_buyer do
    postal_code { Faker::Lorem.characters(number: 3, min_numeric: 3) + '-' + Faker::Lorem.characters(number: 4, min_numeric: 4) }
    city { Faker::Address.city }
    block { Faker::Address.street_address }
    building_name { Faker::Address.street_address }
    phone_number { Faker::Number.number(digits: 11) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    token { Faker::Internet.password(min_length: 20, max_length: 30) }
  end
end
