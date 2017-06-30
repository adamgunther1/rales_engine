class Api::V1::Transactions::FindController < ApplicationController

  def show
    render json: Transaction.find_by(transaction_params)
  end

  private

  def transaction_params
    params.permit(:id, :name, :credit_card_number, :result, :created_at, :updated_at)
  end
end