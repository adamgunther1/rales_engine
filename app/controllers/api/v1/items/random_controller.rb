class Api::V1::Items::RandomController < ApplicationController

  def show
    max = Item.count + 1
    render json: Item.find(rand(max))
  end
end