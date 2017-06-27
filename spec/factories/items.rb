FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "echo#{n}" }
    
    description "it hears everything"
    unit_price 97532
    
    merchant
  end
end
