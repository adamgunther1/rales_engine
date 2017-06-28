class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController

  def index
    sql = "SELECT c.id customer_id, c.first_name, c.last_name FROM merchants m JOIN invoices i ON m.id = i.merchant_id JOIN customers c ON i.customer_id = c.id JOIN transactions t ON t.invoice_id = i.id JOIN invoice_items ii ON i.id = ii.invoice_id WHERE t.result = 1 AND m.id = 17 GROUP BY 1,2,3 ORDER BY 1,2,3 LIMIT 1;"
    result = ActiveRecord::Base.connection.execute(sql).values
    output = {customer_id: customer[0], first_name: customer[1], last_name: customer[2]}
    # output = result.map do |customer|
      # {customer_id: customer[0], first_name: customer[1], last_name: customer[2]}
    # end

    render json: output
  end
end