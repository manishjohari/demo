# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tax_detail do |t|
    country_code "MyString"
    percentage 1
    t.association :product
  end
end
