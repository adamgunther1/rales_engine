require 'csv'
namespace :load do

  desc "Loads seed data from merchants csv file"
  task merchants: :environment do
    Merchant.destroy_all
    csv = import_csv("./db/csv/merchants.csv")
    csv.each do |row|
      Merchant.create!(name: row[:name],
                       created_at: row[:created_at],
                       updated_at: row[:updated_at]
                       )
    end
    puts "Merchants seed is loaded and recorded"
  end

  desc "Loads seed data from items csv file"
  task items: :environment do
    Item.destroy_all
    csv = import_csv("./db/csv/items.csv")
    csv.each do |row|
      Item.create!(name: row[:name],
                  description: row[:description],
                  unit_price: row[:unit_price],
                  merchant_id: row[:merchant_id],
                  created_at: row[:created_at],
                  updated_at: row[:updated_at]
                  )
    end
    puts "Items seed is loaded and recorded"
  end

  desc "Loads seed data from customers csv file"
  task customers: :environment do
    Customer.destroy_all
    csv = import_csv("./db/csv/customers.csv")
    csv.each do |row|
      Customer.create!(first_name: row[:first_name],
                       last_name: row[:last_name],
                       created_at: row[:created_at],
                       updated_at: row[:updated_at]
                       )
    end
    puts "Customers seed is loaded and recorded"
  end

  desc "Loads seed data from invoices csv file"
  task invoices: :environment do
    Invoice.destroy_all
    csv = import_csv("./db/csv/invoices.csv")
    csv.each do |row|
      Invoice.create!(customer_id: row[:customer_id],
                      merchant_id: row[:merchant_id],
                      status: row[:status],
                      created_at: row[:created_at],
                      updated_at: row[:updated_at]
                      )
    end
    puts "Invoices seed is loaded and recorded"
  end

  desc "Loads seed data from transactions csv file"
  task transactions: :environment do
    Transaction.destroy_all
    csv = import_csv("./db/csv/transactions.csv")
    csv.each do |row|
      Transaction.create!(invoice_id: row[:invoice_id],
                      credit_card_number: row[:credit_card_number],
                      credit_card_expiration_date: row[:credit_card_expiration_date],
                      result: row[:result],
                      created_at: row[:created_at],
                      updated_at: row[:updated_at]
                      )
    end
    puts "Transactions seed is loaded and recorded"
  end

  desc "Loads seed data from invoice_items csv file"
  task invoice_items: :environment do
    InvoiceItem.destroy_all
    csv = import_csv("./db/csv/invoice_items.csv")
    csv.each do |row|
      InvoiceItem.create!(invoice_id: row[:invoice_id],
                          item_id: row[:item_id],
                          quantity: row[:quantity],
                          unit_price: row[:unit_price],
                          created_at: row[:created_at],
                          updated_at: row[:updated_at]
                          )
    end
    puts "InvoiceItems seed is loaded and recorded"
  end

  desc "Loads all seed data from csv files"
  task :csv_seed => [:merchants, :items, :customers, :invoices, :transactions, :invoice_items]

  def import_csv(file)
    CSV.open(file, headers: true, header_converters: :symbol)
  end
end