require 'json'
require 'faraday'

class HolidayDataService 
  def load_data(source)
    response = Faraday.get(source)
    JSON.parse(response.body, symbolize_names: true)
  end

  def instantiate_data
    data = load_data('https://date.nager.at/api/v3/NextPublicHolidays/US')
    holidays = data.map do |datum|
      Holiday.new(datum)
    end
  end
end