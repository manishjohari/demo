# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripe_customer do |sc|
    last_4_digits "7897"
    stripe_id "123456yuik"
    customer_id "customer12345"
    card_type "visa"
    exp_month "june"
    exp_year  "2020"
    sc.association :user
  end
end
