require 'rails_helper'

RSpec.describe "Items/BestDay API" do
  context "GET /api/v1/items/:id/best_day" do
    it "returns the date with the most sales for the given item using the invoice date" do
      merchant = create(:merchant_with_items)
      invoice = create(:invoice, merchant_id: merchant.id)
      invoice2 = create(:invoice, merchant_id: merchant.id)
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 0)
      
      get "/api/v1/items/#{merchant.items.first.id}/best_day"

      expect(response).to be_success

      raw_data = JSON.parse(response.body)
      raw_item = raw_data.first
      expect(raw_item).to have_key("best_day")
      expect(raw_item["best_day"]).to be_a String
    end
  end
end