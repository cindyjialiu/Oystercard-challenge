class Oystercard
  DEFAULT_LIMIT = 90
  attr_reader :balance

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
  end

  def top_up(amount)
    raise "Sorry, you've reached the limit of £#{@limit}" if @balance + amount > @limit
    @balance += amount
  end

  def deduct(fare_amount)
    journey = Journey.new
    journey.fare = fare_amount
    @balance -= journey.fare
  end
end
