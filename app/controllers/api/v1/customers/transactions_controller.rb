class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    render json: Customer.find(params[:id]).transactions.order(:id)
  end
end