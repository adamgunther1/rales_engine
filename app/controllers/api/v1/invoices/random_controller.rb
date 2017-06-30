class Api::V1::Invoices::RandomController < ApplicationController

  def show
    max = Invoice.count + 1
    render json: Invoice.find(rand(max))
  end
end