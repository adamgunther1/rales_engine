require 'rails_helper'

describe "Merchants API" do
  context "GET /api/v1/merchants" do
    it "sends all merchants" do
      create_list(:merchant, 5)

      get '/api/v1/merchants'

      expect(response).to be_success

      raw_merchants = JSON.parse(response.body)
      raw_merchant = raw_merchants.first

      expect(raw_merchants.count).to eq(5)
      expect(raw_merchant).to have_key("name")
      expect(raw_merchant["name"]).to be_a String
      # expect(raw_merchant).to have_key("created_at")
      # expect(raw_merchant["created_at"]).to be_a String
      # expect(raw_merchant).to have_key("updated_at")
      # expect(raw_merchant["updated_at"]).to be_a String
    end
  end

  context "GET /api/v1/merchants/:id" do
    it "sends a single merchant by id" do
      merchant = create(:merchant)
      merchant_id = merchant.id

      get "/api/v1/merchants/#{merchant_id}"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant_id)
      expect(raw_merchant).to have_key("name")
      expect(raw_merchant["name"]).to be_a String
      # expect(raw_merchant).to have_key("created_at")
      # expect(raw_merchant["created_at"]).to be_a String
      # expect(raw_merchant).to have_key("updated_at")
      # expect(raw_merchant["updated_at"]).to be_a String     
    end
  end
end