require 'rails_helper'

RSpec.describe "Merchants/MostItemsByQuantity API" do
  context "GET /api/v1/merchants/most_items?quantity=x" do
    it "returns the most items for 'x' number of merchants" do
      merchant = create(:merchant_with_items)
      merchant2 = create(:merchant_with_items)
      merchant3 = create(:merchant_with_items)
      invoice = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      invoice2 = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 0)

      get "/api/v1/merchants/most_items?quantity=7"

      expect(response).to be_success
      
      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant.first).to have_key("id")
      expect(raw_merchant.first).to have_key("name")
      expect(raw_merchant.first).to have_key("total_items_sold")
      expect(raw_merchant.first["id"]).to be_an Integer
      expect(raw_merchant.first["name"]).to be_an String
      expect(raw_merchant.first["total_items_sold"]).to be_a Integer
    end
  end
end