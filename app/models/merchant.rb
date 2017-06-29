class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.revenue_for_all_by_date(date)
    Merchant.find_by_sql [
      "SELECT ROUND(SUM(invoice_items.quantity * invoice_items.unit_price / 100.00), 2) AS total_revenue 
      FROM merchants 
      INNER JOIN items ON merchants.id = items.merchant_id 
      INNER JOIN invoice_items ON items.id = invoice_items.item_id 
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id 
      INNER JOIN transactions ON transactions.invoice_id = invoices.id 
      WHERE invoices.updated_at = ? AND transactions.result = 0;", date ]
  end

  def self.revenue_for_one(id)
    Merchant.find_by_sql [
      "SELECT merchants.name merchant_name, ROUND(SUM(invoice_items.quantity * invoice_items.unit_price / 100.00), 2) AS revenue 
      FROM merchants 
      INNER JOIN items ON merchants.id = items.merchant_id 
      INNER JOIN invoice_items ON items.id = invoice_items.item_id 
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id 
      INNER JOIN transactions ON transactions.invoice_id = invoices.id 
      WHERE merchants.id = ? AND transactions.result = 0 
      GROUP BY merchant_name;", id ]
  end

  def self.revenue_for_one_by_date(id, date)
    Merchant.find_by_sql [
      "SELECT merchants.name merchant_name, invoices.updated_at AS date, ROUND(SUM(invoice_items.quantity * invoice_items.unit_price / 100.00), 2) AS revenue 
      FROM merchants 
      INNER JOIN items ON merchants.id = items.merchant_id 
      INNER JOIN invoice_items ON items.id = invoice_items.item_id 
      INNER JOIN invoices ON invoices.id = invoice_items.invoice_id 
      WHERE invoices.updated_at = ? AND merchants.id = ? 
      GROUP BY merchant_name, date;", date, id ]
  end
end
