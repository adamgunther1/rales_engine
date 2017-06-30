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
    value.first
  end

  def self.revenue_for_one_merchant(id)
    value = Merchant.find_by_sql [
      "SELECT merchants.name merchant_name, ROUND(SUM(invoice_items.quantity * invoice_items.unit_price / 100.00),2) AS revenue 
      FROM merchants 
      INNER JOIN items ON merchants.id = items.merchant_id 
      INNER JOIN invoice_items ON items.id = invoice_items.item_id
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
      INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE merchants.id =  #{id} AND transactions.result = 0
      GROUP BY merchant_name" ]
    value.first
  end

  def self.revenue_for_one_merchant_by_date(id, date)
     value = Merchant.find_by_sql [
      "SELECT merchants.name merchant_name, invoices.updated_at AS date, ROUND(SUM(invoice_items.quantity * invoice_items.unit_price / 100.00),2) AS revenue 
      FROM merchants 
      INNER JOIN items ON merchants.id = items.merchant_id 
      INNER JOIN invoice_items ON items.id = invoice_items.item_id
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
      INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE merchants.id = #{id} AND invoices.updated_at = '#{date}' AND transactions.result = 0
      GROUP BY merchant_name, date" ]
    value.first
  end

  def self.most_items(quantity)
    Merchant.find_by_sql [
      "SELECT merchants.name, merchants.id, SUM(invoice_items.quantity) AS total_items_sold
      FROM merchants 
      INNER JOIN items ON merchants.id = items.merchant_id 
      INNER JOIN invoice_items ON items.id = invoice_items.item_id
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id
      INNER JOIN transactions ON invoices.id = transactions.invoice_id
      WHERE transactions.result = 0
      GROUP BY 1,2
      ORDER BY total_items_sold DESC
      LIMIT  #{quantity}" ]
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
      EXCEPT 
      SELECT c.id id, c.first_name first_name, c.last_name last_name
      FROM merchants m 
      INNER JOIN invoices i ON m.id = i.merchant_id 
      INNER JOIN customers c ON i.customer_id = c.id 
      INNER JOIN transactions t ON t.invoice_id = i.id 
      INNER JOIN invoice_items ii ON i.id = ii.invoice_id 
      WHERE i.status = 0
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
