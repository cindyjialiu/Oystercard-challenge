require 'journey'
require 'oystercard'

describe Journey do

  journey = Journey.new
  oystercard = Oystercard.new(journey)
  let(:entry_station) { double(:station, :name => "Aldgate", :zone => 1) }
  let(:exit_station) { double(:station, :name => "Highams", :zone => 4) }

  describe '#list' do

    it 'should return an empty list of journeys by default' do
      expect(journey.list).to be_empty
    end

    it "should add a journey" do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(journey.list).to eq [{entry: entry_station, exit: exit_station}]
    end
  end

  describe '#in_journey?' do

    it "should know if it's in journey" do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      expect(journey.in_journey?).to eq true
    end

    it "should know if it is out of journey" do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(journey.in_journey?).to eq false
    end

  end

  describe '#fare' do
    it "should be minimum fare" do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(journey.fare).to eq(Journey::MINIMUM_FARE)
    end

    it "should charge 6 if no touch in" do
      oystercard.top_up(10)
      oystercard.touch_out(exit_station)
      expect(journey.fare).to eq(6)
    end

    it "should charge 11 if no touch out" do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(journey.fare).to eq(11)
    end
  end

end
