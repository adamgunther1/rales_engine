class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    sql = "SELECT c.id, c.first_name, c.last_name, SUM(ii.quantity * ii.unit_price) AS total FROM merchants m JOIN invoices i ON m.id = i.merchant_id JOIN customers c ON i.customer_id = c.id JOIN transactions t ON t.invoice_id = i.id JOIN invoice_items ii ON i.id = ii.invoice_id WHERE t.result = 0 AND m.id = #{params[:id]} GROUP BY 1,2,3 ORDER BY 4 DESC LIMIT 1;"
    result = ActiveRecord::Base.connection.execute(sql).values
# binding.pry
    output = {id: result[0][0], first_name: result[0][1], last_name: result[0][2], total: result[0][3]/100.to_f}

    render json: output
  end
end
