class Api::V1::Invoices::FindController < ApplicationController

  def show
    render json: Invoice.find_by(invoice_params)
  end

  private

  def invoice_params
    params.permit(:id, :status, :merchant_id, :customer_id)
  end
end