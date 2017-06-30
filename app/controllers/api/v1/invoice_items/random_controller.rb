class Api::V1::InvoiceItems::RandomController < ApplicationController

  def show
    max = InvoiceItem.count + 1
    render json: InvoiceItem.find(rand(max))
  end
end