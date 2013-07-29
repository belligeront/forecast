require_relative '../../lib/forecast'

module Forecast
  describe Location do

    before do
      @location = Location.new({latitude: 43.086880, longitude: -89.373269})
    end

    it 'responds to .latitude' do
      @location.latitude.should == 43.086880
    end

    it 'responds to .longitude' do
      @location.longitude.should == -89.373269
    end
  end
end
