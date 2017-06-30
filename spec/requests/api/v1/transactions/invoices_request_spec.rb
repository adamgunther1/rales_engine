require 'rails_helper'

RSpec.describe "Transaction/Invoices API" do
  context "GET /api/v1/transactions/:id/invoice" do
    it "returns the associated invoice of a specific transaction" do
      transaction = create(:transaction)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      expect(response).to be_success

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice.count).to eq(4)
      expect(raw_invoice).to have_key("id")
      expect(raw_invoice).to have_key("status")
      expect(raw_invoice).to have_key("customer_id")
      expect(raw_invoice).to have_key("merchant_id")
      expect(raw_invoice["id"]).to eq(transaction.invoice.id)
      expect(raw_invoice["customer_id"]).to eq(transaction.invoice.customer_id)
      expect(raw_invoice["merchant_id"]).to eq(transaction.invoice.merchant_id)
      expect(raw_invoice["status"]).to eq(transaction.invoice.status)
    end
  end
end