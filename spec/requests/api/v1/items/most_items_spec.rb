require 'rails_helper'

RSpec.describe "Items/MostItems API" do
  context "GET /api/v1/items/most_items?quantity=x" do
    it "returns top x items ranked by total revenue generated" do
      merchant = create(:merchant_with_items)
      invoice = create(:invoice, merchant_id: merchant.id)
      invoice2 = create(:invoice, merchant_id: merchant.id)
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 0)

      get "/api/v1/items/most_items?quantity=2"

      expect(response).to be_success

      raw_data = JSON.parse(response.body)
      raw_item = raw_data.first
      expect(raw_item).to have_key("id")
      expect(raw_item).to have_key("name")
      expect(raw_item["id"]).to be_a Integer
      expect(raw_item["name"]).to be_a String
      expect(raw_item["id"]).to eq(merchant.items.last.id)
      expect(raw_item["name"]).to eq(merchant.items.last.name)
    end
  end
end