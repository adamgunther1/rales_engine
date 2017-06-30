class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.favorite_merchant(id)
    value = Customer.find_by_sql [
      "SELECT m.id, m.name, COUNT(t.result) AS total_transactions
      FROM customers c 
      JOIN invoices i ON i.customer_id = c.id  
      JOIN transactions t ON t.invoice_id = i.id 
      JOIN merchants m ON m.id = i.merchant_id 
      WHERE t.result = 0 AND c.id = #{id} 
      GROUP BY 1,2
      ORDER BY 3 DESC 
      LIMIT 1" ]
    value.first
  end
end
