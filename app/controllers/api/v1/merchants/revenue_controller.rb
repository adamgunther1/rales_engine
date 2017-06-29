class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.revenue_for_all_merchants_by_date(params[:date])
  end
end