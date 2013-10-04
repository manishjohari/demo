# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripe_detail do |sd|
    access_token "sk_test_1FqlyqphKZEHgsvFTJ2kwK1H"
    refresh_token "rt_1fx7NynVw6Uhth1r6SmBn2nXwwjjLp8iNXshUAtReR3GoJjm"
    token_type "bearer"
    stripe_publishable_key "pk_test_aGqimlHn3zTtLTbC7nxxcszo"
    stripe_user_id "acct_1fvd8KidFlE9ANW2JhRI"
    scope "read_only"
    sd.association :user
  end
end
