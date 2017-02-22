class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 5
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :journey_hist

  def initialize
    @balance = 0
    @journey_hist = []
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    raise "Unable to top-up below the amount of #{MINIMUM_BALANCE}" if amount < MINIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    raise "Insufficient funds - minimum fare is £#{MINIMUM_FARE}, current balance is £#{@balance}" unless sufficient_funds?
    @entry_station = station
    @journey = {}
    @journey[:entry_station] = @entry_station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey[:exit_station] = station
    @journey_hist << @journey
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def sufficient_funds?
    @balance >= MINIMUM_FARE
  end


end
