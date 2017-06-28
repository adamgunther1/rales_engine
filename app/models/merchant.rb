class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  def self.revenue_for_all_by_date(date)
    sql = "SELECT SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue FROM merchants INNER JOIN items ON merchants.id = items.merchant_id INNER JOIN invoice_items ON items.id = invoice_items.item_id INNER JOIN invoices ON invoices.id = invoice_items.invoice_id INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE invoices.updated_at = '2012-03-16 11:55:05' AND transactions.result = 0;"
    binding.pry
    Merchant.find_by_sql(sql)
  end

  def self.revenue_for_one
    
  end

  def self.revenue_for_one_by_date
    
  end
end
