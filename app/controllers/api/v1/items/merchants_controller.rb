class Api::V1::Items::MerchantsController < ApplicationController
  def index
    item = Item.find(params[:id])
    render json: item.merchant
  end
end