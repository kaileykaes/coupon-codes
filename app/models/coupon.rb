class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  validates :unique_code, uniqueness: true
  enum status: ['Inactive', 'Active']
  enum discount_type: ["Percentage", "Dollar Amount"]

  def times_used
    invoices.joins(:transactions).where("result = 1").count
  end

  def usable_discount
    if discount_type == 'Percentage'
      (discount/100)
    elsif discount_type == 'Dollar Amount'
      discount
    end
  end
end
