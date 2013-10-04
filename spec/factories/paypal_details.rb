# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :paypal_detail do |p|
    email "seller@idify.in"
    first_name "seller"
    last_name "bhatia"
    p.association :user
  end
end
