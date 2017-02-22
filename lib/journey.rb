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
    @entry_station == nil || @exit_station == nil ? PENALTY_FARE : MINIMUM_FARE
  end

  def in_journey?
    !!@entry_station
  end
end
