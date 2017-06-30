require 'rails_helper'

RSpec.describe "Invoice/FindAll API" do
  context "GET /api/v1/invoices/find?params" do
    it "returns all invoices that match a specific id" do
      create_list(:invoice, 4)
      invoice = Invoice.first

      get "/api/v1/invoices/find_all?id=#{invoice.id}"

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first

      expect(raw_invoices.count).to eq(1)
      expect(raw_invoice).to have_key("id")
      expect(raw_invoice).to have_key("status")
      expect(raw_invoice).to have_key("customer_id")
      expect(raw_invoice).to have_key("merchant_id")
      expect(raw_invoice["id"]).to be_a Integer
      expect(raw_invoice["status"]).to be_a String
      expect(raw_invoice["customer_id"]).to be_a Integer
      expect(raw_invoice["merchant_id"]).to be_a Integer
    end

    it "returns all invoices that match a specific status" do
      create_list(:invoice, 3)
      invoice = Invoice.first
      invoice_3 = Invoice.last
      invoice_4 = create(:invoice, status: 0)

      get "/api/v1/invoices/find_all?status=1"

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first
      raw_invoice_3 = raw_invoices.last

      expect(raw_invoices.count).to eq(3)
      expect(raw_invoice["id"]).to eq(invoice.id)
      expect(raw_invoice_3["id"]).to_not eq(invoice_4.id)
      expect(raw_invoice_3["id"]).to eq(invoice_3.id)
      expect(raw_invoice["status"]).to eq(invoice.status)
    end

    it "returns all invoices that match a specific customer id" do
      create_list(:invoice, 3)
      invoice = Invoice.first
      invoice_3 = Invoice.last
      invoice_4 = create(:invoice, customer_id: invoice.customer.id)

      get "/api/v1/invoices/find_all?customer_id=#{invoice.customer.id}"

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first
      raw_invoice_3 = raw_invoices.last

      expect(raw_invoices.count).to eq(2)
      expect(raw_invoice["id"]).to eq(invoice.id)
      expect(raw_invoice_3["id"]).to_not eq(invoice_3.id)
      expect(raw_invoice_3["id"]).to eq(invoice_4.id)
      expect(raw_invoice["customer_id"]).to eq(invoice.customer.id)
    end

    it "returns all invoices that match a specific merchant id" do
      create_list(:invoice, 3)
      invoice = Invoice.first
      invoice_3 = Invoice.last
      invoice_4 = create(:invoice, merchant_id: invoice.merchant.id)

      get "/api/v1/invoices/find_all?merchant_id=#{invoice.merchant.id}"

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first
      raw_invoice_3 = raw_invoices.last

      expect(raw_invoices.count).to eq(2)
      expect(raw_invoice["id"]).to eq(invoice.id)
      expect(raw_invoice_3["id"]).to_not eq(invoice_3.id)
      expect(raw_invoice_3["id"]).to eq(invoice_4.id)
      expect(raw_invoice["merchant_id"]).to eq(invoice.merchant.id)
    end

    it "returns all invoices that match a specific created_at" do
      create_list(:invoice, 3, created_at: "2012-03-04 22:53:51")
      invoice = Invoice.first
      invoice_3 = Invoice.last
      invoice_4 = create(:invoice)

      get "/api/v1/invoices/find_all?created_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first
      raw_invoice_3 = raw_invoices.last

      expect(raw_invoices.count).to eq(3)
      expect(raw_invoice["id"]).to eq(invoice.id)
      expect(raw_invoice_3["id"]).to_not eq(invoice_4.id)
      expect(raw_invoice_3["id"]).to eq(invoice_3.id)
    end

    it "returns all invoices that match a specific updated_at" do
      create_list(:invoice, 3, updated_at: "2012-03-04 22:53:51")
      invoice = Invoice.first
      invoice_3 = Invoice.last
      invoice_4 = create(:invoice)

      get "/api/v1/invoices/find_all?updated_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first
      raw_invoice_3 = raw_invoices.last

      expect(raw_invoices.count).to eq(3)
      expect(raw_invoice["id"]).to eq(invoice.id)
      expect(raw_invoice_3["id"]).to_not eq(invoice_4.id)
      expect(raw_invoice_3["id"]).to eq(invoice_3.id)
    end
  end
end
