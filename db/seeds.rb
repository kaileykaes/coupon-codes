# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Merchant.destroy_all
Item.destroy_all
Customer.destroy_all
Coupon.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all
Transaction.destroy_all

Rake::Task["csv_load:all"].invoke

    Coupon.create!(name: 'A hat', unique_code: 'HAT1',  merchant: Merchant.first, status: 1, invoice_id: Invoice.first, discount: 50, discount_type: 1) #162 subtotal, $112 grand total, $50 off
    Coupon.create!(name: 'A name', unique_code: 'Name1',  merchant: Merchant.first, status: 1, invoice_id: Invoice.all[1], discount: 50, discount_type: 0) # $10 subtotal, $5 grand total, 50% off
    Coupon.create!(name: 'a monkey', unique_code: 'MONKEY',  merchant: Merchant.first, status: 1, invoice_id: Invoice.all[2], discount: 20, discount_type: 1) # $16 subtotal, $0 grand total, $20 off 
    Invoice.first.update(coupon: Coupon.first)
    Invoice.all[3].update(coupon: Coupon.first)
    Invoice.all[4].update(coupon: Coupon.first)

    # invoices 0, 3, & 4 in the database have coupon 1 
    # invoices 1, & 2 in the database have coupon 1 & 2 respectively