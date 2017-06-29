require 'rails_helper'

RSpec.describe "Invoice/Find API" do
  context "GET /api/v1/invoice_items" do
    it "sends all invoice_items" do
      create_list(:invoice, 4)
      invoice = Invoice.first

      get "/api/v1/invoices/find?id=#{invoice.id}"

      expect(response).to be_success

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice.count).to eq(4)
      expect(raw_invoice).to have_key("id")
      expect(raw_invoice).to have_key("status")
      expect(raw_invoice).to have_key("customer_id")
      expect(raw_invoice).to have_key("merchant_id")
      expect(raw_invoice["id"]).to be_a Integer
      expect(raw_invoice["status"]).to be_a String
      expect(raw_invoice["customer_id"]).to be_a Integer
      expect(raw_invoice["merchant_id"]).to be_a Integer
    end

    it "sends all invoice_items" do
      create_list(:invoice, 4)
      invoice = Invoice.first

      get "/api/v1/invoices/find?status=1"

      expect(response).to be_success

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice["id"]).to eq(invoice.id)
      expect(raw_invoice["status"]).to eq(invoice.status)
      expect(raw_invoice["customer_id"]).to eq(invoice.customer.id)
      expect(raw_invoice["merchant_id"]).to eq(invoice.merchant.id)

    end

    it "sends all invoice_items" do
      create_list(:invoice, 4)
      invoice = Invoice.first

      get "/api/v1/invoices/find?customer_id=#{invoice.customer.id}"

      expect(response).to be_success

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice["id"]).to eq(invoice.id)
      expect(raw_invoice["status"]).to eq(invoice.status)
      expect(raw_invoice["customer_id"]).to eq(invoice.customer.id)
      expect(raw_invoice["merchant_id"]).to eq(invoice.merchant.id)
    end

    it "sends all invoice_items" do
      create_list(:invoice, 4)
      invoice = Invoice.first

      get "/api/v1/invoices/find?merchant_id=#{invoice.merchant.id}"

      expect(response).to be_success

      raw_invoice = JSON.parse(response.body)

      expect(raw_invoice["id"]).to eq(invoice.id)
      expect(raw_invoice["status"]).to eq(invoice.status)
      expect(raw_invoice["customer_id"]).to eq(invoice.customer.id)
      expect(raw_invoice["merchant_id"]).to eq(invoice.merchant.id)
    end
  end
end
