require 'rails_helper'

RSpec.describe Holiday, type: :model do
  before(:each) do
    @holiday = Holiday.new({
      name: 'Juneteenth', 
      date: '06/19/23'
    })
  end

  it 'exists and has attributes' do
    expect(@holiday).to be_a(Holiday)
    expect(@holiday.name).to eq('Juneteenth')
    expect(@holiday.date).to eq('06/19/23')
  end
end