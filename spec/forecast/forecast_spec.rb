require_relative '../../lib/forecast'
require_relative '../assets/weather_hash_helper'

module Forecast
  describe Forecast do

    describe "creating a Forecast" do
      it "creates a Location if one doesn't exist" do
        Location.should_receive(:new)
        forecast = Forecast.new
      end
    end

    before do
      @location = double("Location")
      @forecast = Forecast.new(@location)
    end

    subject { @forecast }
    it { should respond_to(:summary) }
    it { should respond_to(:location) }

    describe "getting data from the Forecast Client" do
      it 'sends a :fetch message to a Client object' do
        client = double("Client").stub(:fetch) { WeatherHashHelper.example }
        client.should_receive(:fetch).with(@location)
        @forecast.get(client)
      end
    end
  end
end
