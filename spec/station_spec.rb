require 'station'

describe Station do
  subject(:station) { described_class.new("Bond Street Station") }

  it 'responds to #name' do
    expect(station.name).to eq "Bond Street Station"
  end
end
