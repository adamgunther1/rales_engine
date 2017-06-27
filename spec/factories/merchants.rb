FactoryGirl.define do
  factory :merchant do
    sequence(:name) { |n| "Amazon#{n}" }
  end
end
