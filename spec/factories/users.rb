FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    password "123456"
    password_confirmation "123456"
  end
end
