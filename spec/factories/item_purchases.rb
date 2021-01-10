FactoryBot.define do
  factory :item_purchase do
    token          {"tok_abcdefghijk00000000000000000"}
    portal_code    {"123-1234"}
    prefecture_id  { Faker::Number.within(range: 2..48) }
    city           {"大阪市"}
    address        {"青山１−１"}
    building_name  {"太田ハイツ"}
    phone_number   {"09012341234"}
  end
end
