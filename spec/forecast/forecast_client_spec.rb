require_relative '../../lib/forecast'

module Forecast
  describe Client do

    before do
      @location_double = double("Location")
      @location_double.stub(:latitude) {43.086880}
      @location_double.stub(:longitude) {-89.373269}
      @api_call = Client.new
      @api_call.stub(:raw_json) { File.read 'spec/assets/sample_weather.json' }
    end

    describe '.fetch' do
      it "returns json parsed into a Hash object" do
        @api_call.fetch(@location_double).should be_instance_of(Hash)
      end
    end
  end
end
