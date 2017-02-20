class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 5

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    raise "Unable to top-up below the amount of #{MINIMUM_BALANCE}" if amount < MINIMUM_BALANCE
    @balance += amount
    @balance
  end

end
