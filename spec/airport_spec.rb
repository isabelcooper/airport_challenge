require 'airport'
require 'plane'

describe Airport do

  before(:each) do
    @airport = Airport.new
    @plane = Plane.new
    Airport.send(:public, *Airport.private_instance_methods)
  end

  it 'should add a plane to the array when it lands' do
    @airport.land(@plane)
    expect(@airport.planes_in_airport).to eq([@plane])
  end

  it 'should contain an array of the planes in the airport' do
    @airport.land(@plane)
    expect(@airport.planes_in_airport).to eq([@plane])
  end

  it 'should remove a plane from array when instructed to take off and confirm this has been done' do
    @airport.land(@plane)
    @airport.take_off(@plane)
    expect(@airport.take_off(@plane)).to eq "#{@plane} has now left airport"
  end

  it 'should return sunny weather' do
    srand(5)
    expect(@airport.weather_ok?).to eq(true)
  end

  it 'should return stormy weather' do
    srand(6)
    expect(@airport.weather_ok?).to eq(false)
  end

  it 'should only instruct a plane to take off if weather is not stormy' do
    srand(5)
    expect(@airport.confirm_take_off(@plane)).to eq "#{@plane} has now left airport"
  end

  it 'should not instruct a plane to take off if weather is stormy' do
    srand(6)
    expect(@airport.confirm_take_off(@plane)).to eq nil
  end

  it 'should only instruct a plane to land if weather is not stormy' do
    srand(5)
    expect(@airport.confirm_landing(@plane)).to eq @airport.planes_in_airport
  end

  it 'should not instruct a plane to land if weather is stormy' do
    srand(6)
    expect(@airport.confirm_landing(@plane)).to eq nil
  end

  it 'should not accept planes when the airport is full' do
    100.times { @airport.land(Plane.new) }
    expect { @airport.confirm_landing(@plane) }.to raise_error "No space available"
  end

  it 'should allow inititalize with any capacity' do
    airport50 = Airport.new(50)
    expect(airport50.capacity).to eq 50
  end

  it 'should not accept planes when the airport of capacity 50 is full' do
    airport50 = Airport.new(50)
    50.times { airport50.land(Plane.new) }
    expect { airport50.confirm_landing(@plane) }.to raise_error "No space available"
  end

end
