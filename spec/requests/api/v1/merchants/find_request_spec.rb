require 'rails_helper'

RSpec.describe "Merchant/Find API" do
  context "GET /api/v1/merchants/find?params" do
    it "returns the first merchant it matches to a specific id" do
      create_list(:merchant, 4)
      merchant = Merchant.first

      get "/api/v1/merchants/find?id=#{merchant.id}"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant).to have_key("id")
      expect(raw_merchant).to have_key("name")
      expect(raw_merchant["id"]).to be_a Integer
      expect(raw_merchant["name"]).to be_a String
    end

    it "returns the first merchant it matches to a specific name" do
      create_list(:merchant, 4)
      merchant = Merchant.first

      get "/api/v1/merchants/find?name=#{merchant.name}"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant["name"]).to eq(merchant.name)
    end

    it "returns the first merchant it matches by created at date" do
      create_list(:merchant, 4, created_at: "2012-03-27 11:24:56")
      merchant = Merchant.first

      get "/api/v1/merchants/find?created_at=2012-03-27 11:24:56"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant["name"]).to eq(merchant.name)
    end

    it "returns the first merchant it matches by updated at date" do
      create_list(:merchant, 4, updated_at: "2012-03-27 11:24:56")
      merchant = Merchant.first

      get "/api/v1/merchants/find?updated_at=2012-03-27 11:24:56"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant["name"]).to eq(merchant.name)
    end
  end
end
