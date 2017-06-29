class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    # sql = "SELECT ROUND(SUM(invoice_items.quantity * invoice_items.unit_price / 100.00),2) AS total_revenue FROM merchants INNER JOIN items ON merchants.id = items.merchant_id INNER JOIN invoice_items ON items.id = invoice_items.item_id INNER JOIN invoices ON invoices.id = invoice_items.invoice_id INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE invoices.updated_at = '#{params[:date]}' AND transactions.result = 0;"
    # result = ActiveRecord::Base.connection.execute(sql).values
    # binding.pry
    # output = {total_revenue: result.first.first}

    # render json: output
    render json: Merchant.revenue_for_all_merchants_by_date(params[:date])
  end
end