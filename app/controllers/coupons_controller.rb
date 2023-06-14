class CouponsController < ApplicationController
  before_action :find_merchant_and_coupon, only: [:show]
  before_action :find_merchant, only: [:index, :create, :new]

  def index
    @holidays = HolidayDataService.new.instantiate_holidays[0..2]
  end

  def show; end

  def new; end

  def create
    if @merchant.active_limit_reached? && coupons_params[:status] == 'Active'
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:alert] = "Coupon could not be saved because you have too many coupons active currently"
    else
      coupon = Coupon.new(coupons_params)
      if coupon.save
        redirect_to merchant_coupons_path(@merchant)
      else 
        redirect_to new_merchant_coupon_path(@merchant)
        flash[:alert] = 'Unique code already in use. Please choose a different unique code.'
      end
    end
  end

  def update
    coupon = Coupon.find(params[:id])
    merchant = Merchant.find(params[:merchant_id])
    coupon.update!(coupons_params)
    redirect_to "/merchants/#{merchant.id}/coupons/#{coupon.id}"
  end

  private
  def coupons_params
    params.permit(:id, :unique_code, :name, :status, :merchant_id, :discount, :discount_type)
  end
  
  def find_coupon
    @coupon = Coupon.find(params[:id])
  end
  
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def find_merchant_and_coupon
    @coupon = Coupon.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end
end