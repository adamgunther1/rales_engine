require 'rails_helper'

RSpec.describe "InvoiceItems/Invoices API" do
  context "GET /api/v1/invoice_items/:id/invoice" do
    it "sends all invoices" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      expect(response).to be_success

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice).to have_key("customer_id")
      expect(raw_invoice).to have_key("merchant_id")
      expect(raw_invoice).to have_key("status")
      expect(raw_invoice["customer_id"]).to be_a Integer
      expect(raw_invoice["merchant_id"]).to be_a Integer
      expect(raw_invoice["status"]).to be_a String
    end
  end
end