require_relative '../../lib/forecast'
require_relative '../../lib/forecast/forecast_result'
require_relative '../vcr_helper'

describe "integration betweent Forecast::Client & Forecast::Result" do
  before do
    @location= double("Location")
    @location.stub(:latitude) {43.086880}
    @location.stub(:longitude) {-89.373269}
  end

  it "returns a populated instance of Result" do
    VCR.use_cassette("client_integration") do
      result = Forecast::Client.new.fetch(@location)
      expect(result.current_temp).to be_kind_of Float
      expect(result.minutely_summary).to be_kind_of String
      expect(result.hourly_summary).to be_kind_of String
      expect(result.prob_rain_next_hour).to be >= 0
      result.minutely_precip_prob.each do |probability|
        expect(probability).to be >= 0
      end
    end
  end
end
