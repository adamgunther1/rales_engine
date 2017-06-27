FactoryGirl.define do
  factory :transaction do
    credit_card_number 2222222222222222
    credit_card_expiration_date "2017-06-26"
    result 1
    
    invoice
  end
end
