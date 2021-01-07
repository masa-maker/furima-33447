FactoryBot.define do
  factory :item do
    item_name           { Faker::Name.name }
    info                { Faker::Lorem.sentence }
    price               { Faker::Number.within(range: 300..9_999_999) }
    category_id         { Faker::Number.within(range: 2..11) }
    item_status_id      { Faker::Number.within(range: 2..11) }
    shipping_charge_id  { Faker::Number.within(range: 2..3) }
    prefecture_id       { Faker::Number.within(range: 2..48) }
    shipping_date_id    { Faker::Number.within(range: 2..4) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/hero.jpg'), filename: 'hero.jpg')
    end
  end
end
