require 'oystercard'
require 'station'
require 'journey'

  describe Oystercard do
    #oystercard = Oystercard.new
    subject(:oystercard) {described_class.new}
    subject(:oystercard_empty) {described_class.new}
    let(:entry_station) { double :station, :name => "Aldgate", :zone => 1 }
    let(:exit_station) { double :station, :name => "Highams", :zone => 4 }
    #let(:journey) { {entry_station: entry_station, exit_station: exit_station }}

    before do
      oystercard.balance = 1
    end

    describe "check balance and enforce limits" do

      it 'should have a balance of 0 when initialized' do
        expect(oystercard_empty.balance).to eq 0
      end

      it 'should respond to #top_up by adding money to the balance' do
        expect { oystercard.top_up(10) }.to change {oystercard.balance}.by(10)
      end

      it 'should raise an error when exceed the limit' do
        expect { oystercard.top_up(100) }.to raise_error("Sorry, you've reached the limit of £#{oystercard.limit}")
      end

      it 'should raise an error when below minimum balance' do
        expect { oystercard_empty.touch_in(entry_station) }.to raise_error("Sorry, not enough credit in balance £#{oystercard_empty.balance}")
      end

      it 'should NOT raise an error when at minimum balance' do
        oystercard.top_up(1)
        expect { oystercard.touch_in(entry_station) }.not_to raise_error
      end

      it 'should reduce the balance by minimum fare when touch_out' do
        oystercard.top_up(1)
        oystercard.touch_in(entry_station)
        expect { oystercard.touch_out(exit_station) }.to change {oystercard.balance}.by(-Oystercard::MINIMUM_FARE)
      end

    end

    describe 'keep track of journey history' do

      it 'logs the entry station' do
        oystercard.touch_in(entry_station)
        expect(oystercard.entry_station).to eq entry_station
      end
    end

  end
