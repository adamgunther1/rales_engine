require 'rails_helper'

describe "Invoices/Transactions API" do
  context "GET /api/v1/invoices/:id/transactions" do
    it "returns all transactions" do
      transaction = create(:transaction)

      get "/api/v1/invoices/#{transaction.invoice_id}/transactions"

      expect(response).to be_success

      raw_transactions = JSON.parse(response.body)
      raw_transaction = raw_transactions.first

      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["result"]).to be_a String
    end
  end
end