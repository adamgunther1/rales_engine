class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.revenue_for_all_merchants_by_date(date)
    value = Merchant.find_by_sql [
      "SELECT ROUND(SUM(invoice_items.quantity * invoice_items.unit_price / 100.00),2) AS total_revenue 
      FROM merchants 
      INNER JOIN items ON merchants.id = items.merchant_id 
      INNER JOIN invoice_items ON items.id = invoice_items.item_id 
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id 
      INNER JOIN transactions ON transactions.invoice_id = invoices.id 
      WHERE invoices.updated_at = '#{date}' AND transactions.result = 0" ]
    { "total_revenue" => value.first["total_revenue"] }
  end

  def self.customers_with_pending_invoices(id)
    value = Merchant.find_by_sql [
      "SELECT c.id id, c.first_name first_name, c.last_name last_name
      FROM merchants m 
      INNER JOIN invoices i ON m.id = i.merchant_id 
      INNER JOIN customers c ON i.customer_id = c.id 
      INNER JOIN transactions t ON t.invoice_id = i.id 
      INNER JOIN invoice_items ii ON i.id = ii.invoice_id 
      WHERE t.result = 1 AND m.id = #{id} 
      GROUP BY 1,2,3 
      ORDER BY 1,2,3 
      LIMIT 1;"
    ]
  end

  def self.favorite_customer(id)
    values = Merchant.find_by_sql [
      "SELECT c.id, COUNT(t.result) AS total_transactions 
      FROM merchants m 
      JOIN invoices i ON m.id = i.merchant_id 
      JOIN customers c ON i.customer_id = c.id 
      JOIN transactions t ON t.invoice_id = i.id 
      WHERE t.result = 0 AND m.id = #{id} 
      GROUP BY 1 
      ORDER BY 2 DESC 
      LIMIT 1;"
    ]
    values.first
  end

  def self.most_revenue(quantity)
    value = Merchant.find_by_sql [
      "SELECT m.id, m.name, SUM(ii.quantity * ii.unit_price) revenue
      FROM merchants m
      INNER JOIN items it ON m.id = it.merchant_id
      INNER JOIN invoice_items ii ON it.id = ii.item_id
      INNER JOIN invoices i ON i.id = ii.invoice_id
      INNER JOIN transactions t ON t.invoice_id = i.id
      WHERE t.result = 0
      GROUP BY 1, 2
      ORDER BY 3 DESC
      LIMIT #{quantity};" ]
  end
end
