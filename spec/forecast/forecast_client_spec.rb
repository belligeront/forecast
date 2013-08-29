require_relative '../../lib/forecast'
require_relative '../../lib/forecast/forecast_result'

module Forecast
  describe Client do

    before do
      @location_double = double("Location")
      @location_double.stub(:latitude) {43.086880}
      @location_double.stub(:longitude) {-89.373269}
    end

    describe '.fetch' do
      it "returns a Forecast::Result object with the results" do
        @api_call = Client.new
        @api_call.stub(:raw_json) { File.read 'spec/assets/sample_weather.json' }
        @api_call.fetch(@location_double).should be_instance_of(Result)
      end
    end
  end
end
