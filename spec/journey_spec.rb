require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:entry_station) {"Bank Station"}
  let(:exit_station) {"Oxford Circus"}

  describe '.start_journey' do
    it 'expects journey to start' do
      expect{ journey.start_journey(entry_station) }.to change { journey.entry_station }.to entry_station
    end
  end

  describe '.end_journey' do
    it ' expects journey to end' do
      expect{ journey.end_journey(exit_station) }.to change { journey.exit_station }.to exit_station
    end
  end

  describe '.fare' do
    it ' expects fare to return minimum fare' do
    journey.start_journey(entry_station)
    journey.end_journey(exit_station)
    minimum_fare = Journey::MINIMUM_FARE
    expect(journey.fare).to eq minimum_fare
    end

    it ' gives a penalty fare of 6 if there was no entry station' do
      journey.end_journey(exit_station)
      expect(journey.fare).to eq 6
    end

    it ' gives a penalty fare of 6 if there was no exit station' do
      journey.start_journey(entry_station)
      expect(journey.fare).to eq 6
    end
  end

  describe '.in_journey?' do
    it 'returns true when in journey' do
      journey.start_journey(entry_station)
      expect(journey.in_journey?).to be true
    end

    it 'returns false when not in journey ' do
      expect(journey.in_journey?).to be false
    end
  end
end
