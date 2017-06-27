FactoryGirl.define do
  factory :item do
    name "echo"
    description "it hears everything"
    unit_price 97532
    
    merchant
  end
end
