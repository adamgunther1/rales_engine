class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController

  def index
    sql = "SELECT c.first_name, c.last_name, t.result, i.id, SUM(ii.quantity * ii.unit_price) as total FROM merchants m JOIN invoices i ON m.id = i.merchant_id JOIN customers c ON i.customer_id = c.id JOIN transactions t ON t.invoice_id = i.id JOIN invoice_items ii ON i.id = ii.invoice_id WHERE t.result = 1 GROUP BY 1,2,3,4 ORDER BY 1,2,3,4;"
    result = ActiveRecord::Base.connection.execute(sql).values
    output = result.map do |customer|
      {first_name: customer[0], last_name: customer[1], invoice_id: customer[3], total_pending: customer[4]/100.to_f}
    end

    render json: output
  end
end