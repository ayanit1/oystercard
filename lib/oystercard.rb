require_relative 'journey'

class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 5
  MINIMUM_FARE = 1
  DEFAULT_BALANCE = 0

  attr_reader :balance, :entry_station, :journey_hist

  def initialize
    @balance = DEFAULT_BALANCE
    @journey_hist = []
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    raise "Unable to top-up below the amount of #{MINIMUM_BALANCE}" if amount < MINIMUM_BALANCE
    add_to_balance(amount)
  end

  def touch_in(station)
    raise "Insufficient funds - minimum fare is £#{MINIMUM_FARE}, current balance is £#{@balance}" unless sufficient_funds?
    begin_journey_process
    @current_journey.start_journey(station)
  end

  def touch_out(station)
    deduct_from_balance(MINIMUM_FARE)
    @current_journey.end_journey(station)
  end

  def in_journey?
    @entry_station != nil
  end

  def add_to_balance(amount)
    @balance += amount
  end

  def deduct_from_balance(amount)
    @balance -= amount
  end

  private

  def begin_journey_process
    @current_journey = Journey.new
  end

  def sufficient_funds?
    @balance >= MINIMUM_FARE
  end


end
