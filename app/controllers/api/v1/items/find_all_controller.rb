class Api::V1::Items::FindAllController < ApplicationController

  def show
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].to_f*100
    end
    render json: Item.where(item_params)
  end

  private

  def item_params
    params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
  end
end