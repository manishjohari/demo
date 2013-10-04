# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do |o|
    o.email "tester@example.com"
    o.shipping_option "ordertest"
    o.shipping_country "IN"
    o.shipping_first_name "test"
    o.shipping_last_name "user"
    o.shipping_address1 "address1"
    o.shipping_city "testcity"
    o.shipping_state "DL"
    o.shipping_zip_code "testcode"
    o.association :user
  end
end
