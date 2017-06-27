require 'rails_helper'

RSpec.describe "Invoice Items API" do
  context "GET /api/v1/invoice_items" do
    it "sends all invoice_items" do
      create_list(:invoice_item, 3)

      get "/api/v1/invoice_items"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first

      expect(raw_invoice_items.count).to eq(3)
      expect(raw_invoice_item).to have_key("invoice_id")
      expect(raw_invoice_item).to have_key("item_id")
      expect(raw_invoice_item).to have_key("quantity")
      expect(raw_invoice_item).to have_key("unit_price")
      expect(raw_invoice_item["invoice_id"]).to be_a Integer
      expect(raw_invoice_item["item_id"]).to be_a Integer
      expect(raw_invoice_item["quantity"]).to be_a Integer
      expect(raw_invoice_item["unit_price"]).to be_a Integer
    end
  end

  context "GET /api/v1/invoice_items/:id" do
    it "sends an invoice_item" do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/#{invoice_item.id}"

      raw_invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item).to have_key("invoice_id")
      expect(raw_invoice_item).to have_key("item_id")
      expect(raw_invoice_item).to have_key("quantity")
      expect(raw_invoice_item).to have_key("unit_price")
      expect(raw_invoice_item["invoice_id"]).to be_a Integer
      expect(raw_invoice_item["item_id"]).to be_a Integer
      expect(raw_invoice_item["quantity"]).to be_a Integer
      expect(raw_invoice_item["unit_price"]).to be_a Integer
    end
  end
end
