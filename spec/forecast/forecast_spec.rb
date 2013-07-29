require_relative '../../lib/forecast'
require_relative '../assets/weather_hash_helper'

module Forecast
  describe Forecast do

    before do
      @location = double("Location")
      @forecast = Forecast.new(@location)
    end

    it 'responds to .summary' do
      @forecast.should respond_to(:summary)
    end

    describe '.get_forecast' do
      it 'sends a :fetch message to a Client object' do
        client = double("Client").stub(:fetch) { WeatherHashHelper.example }
        client.should_receive(:fetch).with(@location)
        @forecast.get(client)
      end
    end
  end
end
