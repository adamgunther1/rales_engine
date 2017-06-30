require 'rails_helper'

RSpec.describe "Merchants/Items API" do
  context "GET /api/v1/merchants/:id/items" do
    it "returns a collection of associated items of a specific merchant" do
      merchant = create(:merchant_with_items)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_invoice = raw_items.first
      raw_invoice2 = raw_items.last

      expect(raw_items.count).to eq(5)
      expect(raw_invoice).to have_key("id")
      expect(raw_invoice).to have_key("name")
      expect(raw_invoice).to have_key("description")
      expect(raw_invoice).to have_key("unit_price")
      expect(raw_invoice).to have_key("merchant_id")
      expect(raw_invoice["id"]).to eq(merchant.items.first.id)
      expect(raw_invoice2["id"]).to eq(merchant.items.last.id)
      expect(raw_invoice["merchant_id"]).to eq(merchant.items.first.merchant_id)
    end
  end
end