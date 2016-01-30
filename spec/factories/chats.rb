FactoryGirl.define do
  factory :chat do
    sequence(:name) { |n| "Chat name #{n}." }
  end
end
