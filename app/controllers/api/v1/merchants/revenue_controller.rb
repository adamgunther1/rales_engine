class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.revenue_for_all_by_date(params[:date])
  end

  def show
    if params[:date]
      result = ActiveRecord::Base.connection.execute(sql_w_date).values
    else
      result = ActiveRecord::Base.connection.execute(sql_wo_date).values
    end

    render json: output
  end
end