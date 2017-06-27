FactoryGirl.define do
  factory :invoice_item do
    quantity 2
    unit_price 3684920

    invoice
    item
  end
end
