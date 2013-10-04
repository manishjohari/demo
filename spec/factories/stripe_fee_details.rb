# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripe_fee_detail do |s|
    stripe_transaction_id "stripeu76541"
    fee_type "test"
    currency "USD"
    fee_amount 89
    s.association :stripe_transaction
  end
end
