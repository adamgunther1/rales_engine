class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def index
    render json: Customer.favorite_merchant(params[:id]), serializer: FavoriteMerchantSerializer
  end
end