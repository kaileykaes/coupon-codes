require 'rails_helper'

RSpec.describe HolidayDataService, type: :model do
  before(:each) do
    @hds = HolidayDataService.new
  end

  describe 'initialize' do 
    it 'exists' do
      expect(@hds).to be_a(HolidayDataService)
    end
  end

  describe '#load_data' do 
    it 'can load data from a source' do
      source = 'https://date.nager.at/api/v3/NextPublicHolidays/US'
      data_response = @hds.load_data(source)
      expect(data_response).to be_a(Array)
    end
  end
end