require 'rails_helper'

RSpec.describe "Merchants/Revenue API" do
  context "GET /api/v1/merchants/revenue?date=x" do
    it "returns the total revenue for date 'x' across all merchants" do
      merchant = create(:merchant_with_items)
      invoice = create(:invoice, merchant_id: merchant.id)
      invoice2 = create(:invoice, merchant_id: merchant.id)
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 0)

      get "/api/v1/merchants/revenue?date=#{invoice.created_at.to_s.chomp(' UTC')}"

      expect(response).to be_success
      
      raw_merchant = JSON.parse(response.body)
# binding.pry
      expect(raw_merchant).to have_key("revenue")
      expect(raw_merchant).to have_key("date")
      expect(raw_merchant["revenue"]).to be_a Float
      expect(raw_merchant["date"]).to be_a String
      expect(raw_merchant["revenue"]).to eq(27291.63)
      expect(raw_merchant["date"]).to eq(Date.today.to_s)
    end
  end
end