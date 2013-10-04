# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :paypal_transaction_detail do
    paypal_transaction_id "pay56gty789jik"
    transaction_id "iju78yt6ki888kl"
    transaction_status "pending"
    receiver_amount  10
  end
end
