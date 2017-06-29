require 'rails_helper'

RSpec.describe "Merchants/Revenue API" do
  context "GET /api/v1/merchants/revenue?date=x" do
    it "returns the total revenue for date 'x' across all merchants" do
      merchant = create(:merchant_with_items)
      invoice = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      invoice2 = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 0)

      get "/api/v1/merchants/revenue?date=2012-03-16 11:55:05"

      expect(response).to be_success
      
      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant).to have_key("total_revenue")
      expect(raw_merchant["total_revenue"]).to be_a String
      expect(raw_merchant["total_revenue"]).to eq("24712.95")
    end
  end

  context "GET /api/v1/merchants/:id/revenue?date=x" do
    it "returns the total revenue for date 'x' for one merchant" do
      merchant = create(:merchant_with_items)
      invoice = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      invoice2 = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 0)

      get "/api/v1/merchants/#{merchant.id}/revenue?date=2012-03-16 11:55:05"

      expect(response).to be_success
      
      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant).to have_key("revenue")
      expect(raw_merchant["revenue"]).to be_a String
      expect(raw_merchant["revenue"]).to eq("24712.95")
    end
  end
end