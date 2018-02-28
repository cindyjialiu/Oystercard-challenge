require 'journey'
require 'oystercard'

describe Journey do
  oystercard = Oystercard.new ### Need to make this a double at some point
  subject(:journeys) {described_class.new}

  it 'should return an empty list of journeys by default' do
      expect(list.journeys).to be_empty
    end

end
