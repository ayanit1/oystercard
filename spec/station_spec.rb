require 'station'

describe Station do
  subject(:station) { Station.new("Bond Street Station", 1) }

  it 'knows its name' do
    expect(subject.name).to eq("Bond Street Station")
  end

  it 'knows its zone' do
    expect(subject.zone).to eq(1)
  end
end
