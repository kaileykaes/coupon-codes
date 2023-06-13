class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  belongs_to :coupon, optional: true
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def grand_total
    if coupon.discount_type == 'Percentage Off'
      total_revenue - (total_revenue * coupon.usable_discount)
    else
    # elsif coupon.discount_type == 'Dollar Amount'
      total_revenue - coupon.usable_discount
    end
  end
end
