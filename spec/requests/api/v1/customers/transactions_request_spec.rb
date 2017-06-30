require 'rails_helper'

RSpec.describe "Customer/Transactions API" do
  context "GET /api/v1/customers/:id/transactions" do
    it "returns a collection of associated transactions of a specific customer" do
      customer = create(:customer)
      invoice1, invoice2 = create_list(:invoice, 2, customer_id: customer.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice2.id)

      get "/api/v1/customers/#{customer.id}/transactions"

      expect(response).to be_success

      raw_transactions = JSON.parse(response.body)
      raw_transaction = raw_transactions.first
      raw_transaction2 = raw_transactions.last

      expect(raw_transactions.count).to eq(2)
      expect(raw_transaction).to have_key("id")
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["id"]).to eq(customer.transactions.first.id)
      expect(raw_transaction2["id"]).to eq(customer.transactions.last.id)
      expect(raw_transaction["invoice_id"]).to eq(customer.transactions.first.invoice_id)
    end
  end
end