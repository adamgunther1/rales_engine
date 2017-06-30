require 'rails_helper'

describe "Items/Merchants API" do
  context "GET /api/v1/items/:id/merchant" do
    it "returns merchant that item belongs to" do
      item = create(:item)
      item2 = create(:item, merchant_id: item.merchant_id)

      get "/api/v1/items/#{item.id}/merchant"

      expect(response).to be_success

      raw_merchants = JSON.parse(response.body)

      expect(raw_merchants.count).to eq(2)
      expect(raw_merchants).to have_key("name")
      expect(raw_merchants["name"]).to be_a String
    end
  end
end