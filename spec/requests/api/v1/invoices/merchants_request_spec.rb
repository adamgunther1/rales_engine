require 'rails_helper'

describe "Invoices/Merchants API" do
  context "GET /api/v1/invoices/:id/merchant" do
    it "returns the merchant" do
      invoice = create(:invoice)

      get "/api/v1/invoices/#{invoice.id}/merchant"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant).to have_key("name")
      expect(raw_merchant["name"]).to be_a String
    end
  end
end