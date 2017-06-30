require 'rails_helper'

RSpec.describe "Customer/Invoices API" do
  context "GET /api/v1/customers/:id/invoices" do
    it "returns a collection of associated invoices of a specific customer" do
      customer = create(:customer)
      create_list(:invoice, 2, customer_id: customer.id)

      get "/api/v1/customers/#{customer.id}/invoices"

      expect(response).to be_success

      raw_invoices = JSON.parse(response.body)
      raw_invoice = raw_invoices.first
      raw_invoice2 = raw_invoices.last

      expect(raw_invoices.count).to eq(2)
      expect(raw_invoice).to have_key("id")
      expect(raw_invoice).to have_key("status")
      expect(raw_invoice).to have_key("customer_id")
      expect(raw_invoice).to have_key("merchant_id")
      expect(raw_invoice["id"]).to eq(customer.invoices.first.id)
      expect(raw_invoice2["id"]).to eq(customer.invoices.last.id)
      expect(raw_invoice["customer_id"]).to eq(customer.invoices.first.customer_id)
    end
  end
end