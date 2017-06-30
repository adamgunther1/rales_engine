require 'rails_helper'

describe "Invoices/Customers API" do
  context "GET /api/v1/invoices/:id/customer" do
    it "returns all customers" do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)

      get "/api/v1/invoices/#{invoice.id}/customer"

      expect(response).to be_success

      raw_customers = JSON.parse(response.body)

      expect(raw_customers).to have_key("first_name")
      expect(raw_customers["first_name"]).to be_a String
      expect(raw_customers).to have_key("last_name")
      expect(raw_customers["last_name"]).to be_a String
    end
  end
end