class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :merchant
      t.references :customer
      t.references :coupon
      t.integer :status

      t.timestamps
    end
  end
end
