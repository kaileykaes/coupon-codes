require 'rails_helper'

RSpec.describe Invoice, type: :model do
  before(:each) do 
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

    @coupon_1 = create(:coupon, merchant: @merchant1, status: 1, discount: 50, discount_type: 1) #90.00 total revenue, #$40.00 grand total
    @coupon_2 = create(:coupon, merchant: @merchant1, status: 1, discount: 50, discount_type: 0) #10.00 total, 5.00 grand total

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon_id: @coupon_1.id, created_at: "2012-03-27 14:54:09")
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon_id: @coupon_2.id, created_at: "2012-03-28 14:54:09")
    @invoice_3 = Invoice.create!(customer_id: @customer_1.id, status: 2, coupon_id: @coupon_1.id, created_at: "2012-03-28 14:54:09")

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
  end

  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  describe "relationships" do
    it {should belong_to(:coupon).optional }
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end

  describe "instance methods" do
    it "total_revenue" do
      expect(@invoice_1.total_revenue).to eq(100)
    end

    it '#grand_total(dollars off)' do 
      expect(@invoice_3.grand_total).to eq(40.00)
    end
    
    it '#grand_total(percentage off)' do 
      expect(@invoice_2.grand_total).to eq(9.5)
    end
  end
end
