require 'rails_helper'

RSpec.describe "Merchants/Invoices API" do
  context "GET /api/v1/merchants/:id/invoices" do
    it "returns a collection of associated invoices of a specific merchant" do
      merchant = create(:merchant)
      create_list(:invoice, 2, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first
      raw_invoice2 = raw_invoices.last

      expect(raw_invoices.count).to eq(2)
      expect(raw_invoice).to have_key("id")
      expect(raw_invoice).to have_key("status")
      expect(raw_invoice).to have_key("merchant_id")
      expect(raw_invoice).to have_key("merchant_id")
      expect(raw_invoice["id"]).to eq(merchant.invoices.first.id)
      expect(raw_invoice2["id"]).to eq(merchant.invoices.last.id)
      expect(raw_invoice["merchant_id"]).to eq(merchant.invoices.first.merchant_id)
    end
  end
end