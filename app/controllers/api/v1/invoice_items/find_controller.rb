class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].to_f*100
    end
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  private

  def invoice_item_params
    params.permit(:id, :invoice_id, :item_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end