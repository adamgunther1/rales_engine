require 'rails_helper'

describe "Transactions API" do
  context "GET /api/v1/transactions" do
    it "sends all transactions" do
      create_list(:transaction, 5)

      get '/api/v1/transactions'

      expect(response).to be_success

      raw_transactions = JSON.parse(response.body)
      raw_transaction = raw_transactions.first

      expect(raw_transactions.count).to eq(5)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction).to have_key("credit_card_expiration_date")
      expect(raw_transaction["credit_card_expiration_date"]).to be_a String
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["result"]).to be_a Integer
      expect(raw_transaction).to have_key("created_at")
      expect(raw_transaction["created_at"]).to be_a String
      expect(raw_transaction).to have_key("updated_at")
      expect(raw_transaction["updated_at"]).to be_a String
    end
  end

  context "GET /api/v1/transactions/:id" do
    it "sends a single transaction by id" do
      transaction = create(:transaction)
      transaction_id = transaction.id

      get "/api/v1/transactions/#{transaction_id}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction["id"]).to eq(transaction_id)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction).to have_key("credit_card_expiration_date")
      expect(raw_transaction["credit_card_expiration_date"]).to be_a String
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["result"]).to be_a Integer
      expect(raw_transaction).to have_key("created_at")
      expect(raw_transaction["created_at"]).to be_a String
      expect(raw_transaction).to have_key("updated_at")
      expect(raw_transaction["updated_at"]).to be_a String
    end
  end
end