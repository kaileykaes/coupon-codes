require 'json'
require 'faraday'

class HolidayDataService 
  def load_data(source)
    response = Faraday.get(source)
    JSON.parse(response.body, symbolize_names: true)
  end
end