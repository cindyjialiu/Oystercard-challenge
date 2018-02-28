require 'journey'
require 'oystercard'

describe Journey do
  journey = Journey.new
  oystercard = Oystercard.new(journey)

  describe '#list' do
  let(:entry_station) { double(:station, :name => "Aldgate", :zone => 1) }
  let(:exit_station) { double(:station, :name => "Highams", :zone => 4) }


  it 'should return an empty list of journeys by default' do
      expect(journey.list).to be_empty
    end

  it "should add a journey" do
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(journey.list).to eq [{:entry_station => :exit_station}]
  end
end
end
