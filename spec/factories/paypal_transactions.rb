# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :paypal_transaction do
    buyer_email "testpaypal@eample.com"
    seller_email "seller@example.com"
  end
end
