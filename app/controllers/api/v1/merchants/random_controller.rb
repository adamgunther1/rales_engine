class Api::V1::Merchants::RandomController < ApplicationController

  def show
    max = Merchant.count + 1
    render json: Merchant.find(rand(max))
  end
end