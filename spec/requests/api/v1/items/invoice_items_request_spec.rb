require 'rails_helper'

RSpec.describe "Items/Invoice Items API" do
  context "GET /api/v1/items/:id/invoice_items" do
    it "returns all invoice_items" do
      invoice_item = create(:invoice_item)
      invoice_item2 = create(:invoice_item, item_id: invoice_item.item_id)


      get "/api/v1/items/#{invoice_item.item_id}/invoice_items"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first

      expect(raw_invoice_items.count).to eq(2)
      expect(raw_invoice_item).to have_key("invoice_id")
      expect(raw_invoice_item).to have_key("item_id")
      expect(raw_invoice_item).to have_key("quantity")
      expect(raw_invoice_item).to have_key("unit_price")
      expect(raw_invoice_item["invoice_id"]).to be_a Integer
      expect(raw_invoice_item["item_id"]).to be_a Integer
      expect(raw_invoice_item["quantity"]).to be_a Integer
      expect(raw_invoice_item["unit_price"]).to be_a String
    end
  end
end