class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  def index
    invoice_item = InvoiceItem.find(params[:id])
    render json: invoice_item.invoice
  end
end