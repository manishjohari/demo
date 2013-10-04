# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do |p|
    setting = FactoryGirl.create(:configuration_setting)
    name "canon"
    price 30
    image  File.new(Rails.root + 'app/assets/images/rails.png') 
    tax_details_attributes "0"=>{:country_code=>"fff", :percentage=> 10}
    shipping_options_attributes "0" => {:name => "ship", :price=>10}
    p.association :user
    p.association :category
  end
end
