FactoryGirl.define do
  factory :message do
    sequence(:text) { |n| "Message text #{n}." }
    user
    chat
  end
end
