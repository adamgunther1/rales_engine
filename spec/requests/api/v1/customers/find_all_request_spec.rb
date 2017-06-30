require 'rails_helper'

RSpec.describe "Customer/FindAll API" do
  context "GET /api/v1/customers/find_all?params" do
    it "returns the first customer it matches to a specific id" do
      create_list(:customer, 4)
      customer = Customer.first

      get "/api/v1/customers/find_all?id=#{customer.id}"

      expect(response).to be_success

      raw_customer = JSON.parse(response.body).first

      expect(raw_customer).to have_key("id")
      expect(raw_customer).to have_key("first_name")
      expect(raw_customer).to have_key("last_name")
      expect(raw_customer["id"]).to be_a Integer
      expect(raw_customer["first_name"]).to be_a String
      expect(raw_customer["last_name"]).to be_a String
    end

    it "returns the first customer it matches to a first name" do
      create_list(:customer, 4)
      customer = Customer.first

      get "/api/v1/customers/find_all?first_name=#{customer.first_name}"

      expect(response).to be_success

      raw_customer = JSON.parse(response.body).first

      expect(raw_customer).to have_key("id")
      expect(raw_customer).to have_key("first_name")
      expect(raw_customer).to have_key("last_name")
      expect(raw_customer["id"]).to be_a Integer
      expect(raw_customer["first_name"]).to be_a String
      expect(raw_customer["last_name"]).to be_a String
    end

    it "returns the first customer it matches to a last name" do
      create_list(:customer, 4)
      customer = Customer.first

      get "/api/v1/customers/find_all?last_name=#{customer.last_name}"

      expect(response).to be_success

      raw_customer = JSON.parse(response.body).first

      expect(raw_customer).to have_key("id")
      expect(raw_customer).to have_key("first_name")
      expect(raw_customer).to have_key("last_name")
      expect(raw_customer["id"]).to be_a Integer
      expect(raw_customer["first_name"]).to be_a String
      expect(raw_customer["last_name"]).to be_a String
    end

    it "returns the first customer it matches by created at date" do
      create_list(:customer, 4, created_at: "2012-03-27 11:24:56")
      customer = Customer.first

      get "/api/v1/customers/find_all?created_at=2012-03-27 11:24:56"

      expect(response).to be_success

      raw_customer = JSON.parse(response.body).first

      expect(raw_customer).to have_key("id")
      expect(raw_customer).to have_key("first_name")
      expect(raw_customer).to have_key("last_name")
      expect(raw_customer["id"]).to be_a Integer
      expect(raw_customer["first_name"]).to be_a String
      expect(raw_customer["last_name"]).to be_a String
    end

    it "returns the first customer it matches by updated at date" do
      create_list(:customer, 4, updated_at: "2012-03-27 11:24:56")
      customer = Customer.first

      get "/api/v1/customers/find_all?updated_at=2012-03-27 11:24:56"

      expect(response).to be_success

      raw_customer = JSON.parse(response.body).first

      expect(raw_customer).to have_key("id")
      expect(raw_customer).to have_key("first_name")
      expect(raw_customer).to have_key("last_name")
      expect(raw_customer["id"]).to be_a Integer
      expect(raw_customer["first_name"]).to be_a String
      expect(raw_customer["last_name"]).to be_a String
    end
  end
end
