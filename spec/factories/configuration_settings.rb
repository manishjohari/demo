# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :configuration_setting do
    auto_sign_out_duration 1
    mobile_verification 0
    delete_product 4
    block_product_display 2
    membership_fees_per_month 500
    commission_premium_percent 1.5
    commission_basic_percent 2.5
    commission_calculated_on "price"
  end
end
