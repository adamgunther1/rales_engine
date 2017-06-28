class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def index
    sql = "SELECT c.id, COUNT(t.result) AS total_transactions FROM merchants m JOIN invoices i ON m.id = i.merchant_id JOIN customers c ON i.customer_id = c.id JOIN transactions t ON t.invoice_id = i.id WHERE t.result = 0 AND m.id = #{params{:id}} GROUP BY 1 ORDER BY 2 DESC LIMIT 1;"
    result = ActiveRecord::Base.connection.execute(sql).values
# binding.pry
    output = {id: result[0][0], total: result[0][1]/100.to_f}

    render json: output
  end
end
