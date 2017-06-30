require 'rails_helper'

RSpec.describe "InvoiceItems/Items API" do
  context "GET /api/v1/invoice_items/item" do
    it "sends all items" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)

      expect(raw_items).to have_key("name")
      expect(raw_items).to have_key("description")
      expect(raw_items).to have_key("unit_price")
      expect(raw_items).to have_key("merchant_id")
      expect(raw_items["name"]).to be_a String
      expect(raw_items["description"]).to be_a String
      expect(raw_items["unit_price"]).to be_a String
      expect(raw_items["merchant_id"]).to be_a Integer
    end
  end
end
