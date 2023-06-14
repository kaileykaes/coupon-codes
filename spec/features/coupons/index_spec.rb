require 'rails_helper' 

RSpec.describe 'Coupons Index', type: :feature do
  before :each do 
    @dolly = create(:merchant)
    @coupon_1 = create(:coupon, merchant: @dolly, status: 1)
    @coupon_2 = create(:coupon, merchant: @dolly, status: 1)
    @coupon_3 = create(:coupon, merchant: @dolly, status: 0)
    @coupon_4 = create(:coupon, merchant: @dolly, status: 0)
    @coupon_5 = create(:coupon, merchant: @dolly, status: 0)
    visit(merchant_coupons_path(@dolly))
  end

  describe 'merchant coupons' do 
   xit 'lists coupon names and amount off' do 
      within("#coupons") do 
        expect(page).to have_content(@coupon_1.name)
        expect(page).to have_content(@coupon_1.discount)
        expect(page).to have_content(@coupon_2.name)
        expect(page).to have_content(@coupon_1.discount)
      end
    end
    
   xit 'coupon names are links to coupon show pages' do 
      within("#coupon-#{@coupon_1.id}") do 
        expect(page).to have_link("#{@coupon_1.name}", href: merchant_coupon_path(@dolly, @coupon_1))
        click_link("#{@coupon_1.name}")
        expect(current_path).to eq(merchant_coupon_path(@dolly, @coupon_1))
      end

      # within("#coupon-#{@coupon_2.id}") do  
      #   expect(page).to have_link("#{@coupon_2.name}", href: merchant_coupon_path(@dolly, @coupon_2))
      #   click_link("#{@coupon_2.name}")
      #   expect(current_path).to eq(merchant_coupon_path(@dolly, @coupon_2))
      # end
    end

   xit 'has link to coupon create page' do 
      expect(page).to have_link('Create a New Coupon', href: new_merchant_coupon_path(@dolly))
      click_link('Create a New Coupon')
      expect(current_path).to eq(new_merchant_coupon_path(@dolly))
    end
  end

  describe 'merchant coupons sort' do 
   xit 'merchant coupons are sorted by activeness' do 

      within("#active") do 
        expect(page).to have_content("Active Coupons")
        expect(page).to have_link(@coupon_1.name)
        expect(page).to have_link(@coupon_2.name)
        expect(page).to_not have_link(@coupon_3.name)
      end

      within("#inactive") do 
        expect(page).to have_content("Inactive Coupons")
        expect(page).to have_link(@coupon_3.name)
        expect(page).to have_link(@coupon_4.name)
        expect(page).to have_link(@coupon_5.name)
        expect(page).to_not have_link(@coupon_2.name)
      end
    end
  end

  describe 'Upcoming Holidays' do 
   xit 'displays next 3 upcoming holidays' do 
      within("#holidays") do 
        expect(page).to have_content('Juneteenth, 2023-06-19')
        expect(page).to have_content('Independence Day, 2023-07-04')
        expect(page).to have_content('Labour Day, 2023-09-04')
      end
    end
  end
end
# I see a section with a header of "Upcoming Holidays"
# In this section the name and date of the next 3 upcoming US holidays are listed.

