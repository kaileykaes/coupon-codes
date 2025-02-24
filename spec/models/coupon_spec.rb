require 'rails_helper'

RSpec.describe Coupon, type: :model do
  before(:each) do 
    @merchant = create(:merchant)
    @customer = create(:customer)
    @coupon = create(:coupon, merchant: @merchant)
    @percentage_coupon = create(:coupon, merchant: @merchant, status: 1, discount: 50, discount_type: 0) 
    @dollars_coupon = create(:coupon, merchant: @merchant, status: 1, discount: 50, discount_type: 1) 
    @invoice = create(:invoice, coupon: @coupon, customer: @customer)
    @invoice_2 = create(:invoice, coupon: @coupon, customer: @customer)
    @invoice_3 = create(:invoice, coupon: @coupon, customer: @customer)
    @transaction_1 = create(:transaction, invoice: @invoice, result: 1)
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: 1)
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: 0)
  end
  
  describe 'relationships' do 
    it {should belong_to :merchant}
    it {should have_many :invoices}
  end

  describe 'validations' do 
    it {should validate_uniqueness_of :unique_code} 
  end

  describe 'enums' do 
    it { should define_enum_for :status }
    it { should define_enum_for :discount_type }
  end

  describe 'instance methods' do 
    it '#times_used' do 
      expect(@coupon.times_used).to eq(2)
    end

    it 'usable_discount' do 
      expect(@percentage_coupon.usable_discount).to eq(0.5)
      expect(@dollars_coupon.usable_discount).to eq(50)
    end
  end
end
