class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

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
      LIMIT #{quantity};" ]
  end
end
