require 'rails_helper'

RSpec.describe "Invoices/Items API" do
  context "GET /api/v1/invoices/:id/items" do
    it "sends all items" do
      invoice_item = create(:invoice_item)
      invoice_item2 = create(:invoice_item, invoice_id: invoice_item.invoice_id)

      get "/api/v1/invoices/#{invoice_item.invoice_id}/items"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first

      expect(raw_items.count).to eq(2)
      expect(raw_item).to have_key("name")
      expect(raw_item).to have_key("description")
      expect(raw_item).to have_key("unit_price")
      expect(raw_item).to have_key("merchant_id")
      expect(raw_item["name"]).to be_a String
      expect(raw_item["description"]).to be_a String
      expect(raw_item["unit_price"]).to be_a String
      expect(raw_item["merchant_id"]).to be_a Integer
    end
  end
end
