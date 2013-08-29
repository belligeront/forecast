require_relative '../../lib/forecast'
require_relative '../../lib/forecast/forecast_result'
require_relative '../vcr_helper'

module Forecast
  describe Client do

    before do
      @location_double = double("Location")
      @location_double.stub(:latitude) {43.086880}
      @location_double.stub(:longitude) {-89.373269}
    end

    describe '.fetch' do
      it "returns a Forecast::Result object with the results" do
        VCR.use_cassette("client_spec_forecast") do
          @api_call = Client.new
          @api_call.fetch(@location_double).should be_instance_of(Result)
        end
      end
    end
  end
end
