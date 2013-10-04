# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |u|
   u.password "password"
   u.password_confirmation "password"
   u.sequence(:email) { |n| "tester#{n}@example.com"}
  end
end
