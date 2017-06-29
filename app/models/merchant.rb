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

end
