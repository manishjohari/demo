# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription_content do
    subject "testsubscription"
    message "testmessage"
    mail_type "one_time"
    include_cross_sell_products true
    user_type "buyers"
    at "2010-02-11 00:00:00"
  end
end
