class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.revenue_for_all_merchants_by_date(params[:date])
  end

  def show
    if params[:date]
      render json: Merchant.revenue_for_one_merchant_by_date(params[:id], params[:date])
    else
      render json: Merchant.revenue_for_one_merchant(params[:id])
    end
  end
end