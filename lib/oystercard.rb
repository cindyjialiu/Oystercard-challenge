require_relative 'station.rb'
require_relative 'journey.rb'

class Oystercard
  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 5

  attr_accessor :balance, :minimum_balance, :entry_station, :journey, :limit

  def initialize(journey = Journey.new)
    @balance = 0
    @entry_station = nil
    @limit = DEFAULT_LIMIT
    @journey = journey
  end

  def top_up(amount)
    raise "Sorry, you've reached the limit of £#{@limit}" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Sorry, not enough credit in balance £#{@balance}" if @balance < MINIMUM_BALANCE
    @journey.add_entry(station)
    @entry_station = station
    @journey.entry = station
  end

  def touch_out(station)
    @journey.in_journey?
    @journey.add_exit(station)
    deduct(@journey.fare)
    @entry_station = nil
    @journey.entry = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
