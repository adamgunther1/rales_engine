class Api::V1::Items::FindController < ApplicationController

  def show
    if params[:unit_price]
      params[:unit_price] = (params[:unit_price].to_f*100).ceil
    end
    render json: Item.order(:id).find_by(item_params)
  end

  private

  def item_params
    params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
  end
end