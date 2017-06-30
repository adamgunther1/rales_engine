class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_items(quantity)
    Item.find_by_sql [
      "SELECT it.id, it.name, SUM(ii.quantity) items
      FROM items it
      INNER JOIN invoice_items ii ON it.id = ii.item_id
      INNER JOIN invoices i ON i.id = ii.invoice_id
      INNER JOIN transactions t ON t.invoice_id = i.id
      WHERE t.result = 0
      GROUP BY 1, 2
      ORDER BY 3 DESC
      LIMIT #{quantity}" ]
  end

  def self.most_revenue(quantity)
    value = Item.find_by_sql [
      "SELECT it.id, it.name, SUM(ii.quantity * ii.unit_price) revenue
      FROM items it
      INNER JOIN invoice_items ii ON it.id = ii.item_id
      INNER JOIN invoices i ON i.id = ii.invoice_id
      INNER JOIN transactions t ON t.invoice_id = i.id
      WHERE t.result = 0
      GROUP BY 1, 2
      ORDER BY 3 DESC
      LIMIT #{quantity}" ]
  end

  def self.best_day(id)
    value = Item.find_by_sql [
      "SELECT invoices.created_at best_day, SUM(invoice_items.quantity) total_items_sold 
      FROM invoices 
      INNER JOIN invoice_items invoice_items_invoices ON invoice_items_invoices.invoice_id = invoices.id 
      INNER JOIN transactions ON transactions.invoice_id = invoices.id 
      INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id 
      WHERE invoice_items.item_id = #{id} AND transactions.result = 0 
      GROUP BY invoices.id, best_day
      ORDER BY total_items_sold DESC, best_day DESC 
      LIMIT 1;" ]
    value.first
  end
end
