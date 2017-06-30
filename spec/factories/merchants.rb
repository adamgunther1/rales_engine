FactoryGirl.define do
  factory :merchant do
    sequence(:name) { |n| "Amazon#{n}" }

    factory :merchant_with_items do
      transient do
        item_count 5
      end

      after(:create) do |merchant, evaluator|
        merchant.items << create_list(:item, evaluator.item_count)
      end
    end
  end
end
