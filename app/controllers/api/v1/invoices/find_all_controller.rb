class Api::V1::Invoices::FindAllController < ApplicationController

  def show
    render json: Invoice.where(invoice_params)
  end

  private

  def invoice_params
    params.permit(:id, :status, :merchant_id, :customer_id, :created_at, :updated_at)
  end
end