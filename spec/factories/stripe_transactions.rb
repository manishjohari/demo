# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripe_transaction do |st|
    seller_stripe_id "seller876y6t543"
    stripe_charge_id "stp9i8u76yt56789"
    customer "testcustomer"
    last4 "9874"
    card_type "visa"
    exp_month "june"
    exp_year "2020"
    paid true
    amount 100
    currency "USD"
    fee_amount 20
  end
end 
