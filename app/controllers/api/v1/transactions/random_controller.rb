class Api::V1::Transactions::RandomController < ApplicationController

  def show
    max = Transaction.count + 1
    render json: Transaction.find(rand(max))
  end
end