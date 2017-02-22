class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def fare
    if @entry_station == nil || @exit_station == nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

  def in_journey?
    return false if @entry_station == nil && @exit_station == nil
    return false if @entry_station && @exit_station
    return true if @entry_station && @exit_station == nil
    false
  end
end
