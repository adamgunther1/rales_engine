class Api::V1::Merchants::RevenueController < ApplicationController

  def index
        binding.pry
        @something = Merchant.revenue_for_all_by_date(params[:date])
        binding.pry
    render json: @something
  end

  def show
    sql_wo_date = "SELECT merchants.name merchant_name, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue FROM merchants INNER JOIN items ON merchants.id = items.merchant_id INNER JOIN invoice_items ON items.id = invoice_items.item_id INNER JOIN invoices ON invoices.id = invoice_items.invoice_id INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE merchants.id =  #{params[:id]} AND transactions.result = 0 GROUP BY merchant_name;"
    sql_w_date = "SELECT merchants.name merchant_name, invoices.updated_at AS date, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue FROM merchants INNER JOIN items ON merchants.id = items.merchant_id INNER JOIN invoice_items ON items.id = invoice_items.item_id INNER JOIN invoices ON invoices.id = invoice_items.invoice_id WHERE invoices.updated_at = #{params[:date]} AND merchants.id = #{params[:id]} GROUP BY merchant_name, date;"
    if params[:date]
      result = ActiveRecord::Base.connection.execute(sql_w_date).values
    else
      result = ActiveRecord::Base.connection.execute(sql_wo_date).values
    end

    output = {revenue: result.first.last/100.to_f}

    render json: output
  end
end