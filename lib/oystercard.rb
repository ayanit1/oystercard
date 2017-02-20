class OysterCard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise 'Cannot top up, reached maximum limit of 90' if @balance + amount > 90
    @balance += amount
    @balance
  end

end
