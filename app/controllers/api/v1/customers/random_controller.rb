class Api::V1::Customers::RandomController < ApplicationController

  def show
    max = Customer.count + 1
    render json: Customer.find(rand(max))
  end
end