require 'station'
describe Station do

  subject(:station) { station = Station.new("Aldgate",1) }

  it 'create the station with the name' do
    expect(station.name).to eq ("Aldgate")
  end

  it 'create the station with the zone' do
    expect(station.zone).to eq 1
  end
end
