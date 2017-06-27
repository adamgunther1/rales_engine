class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    sql = "SELECT DATE(invoice_items.updated_at) AS date, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue FROM merchants INNER JOIN items ON merchants.id = items.merchant_id INNER JOIN invoice_items ON items.id = invoice_items.item_id WHERE DATE(invoice_items.updated_at) = '#{params[:date]}' GROUP BY date"
    result = ActiveRecord::Base.connection.execute(sql).values
    output = {date: result.first.first, revenue: result.first.last/100.to_f}

    render json: output
  end
end