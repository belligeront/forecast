require_relative '../../lib/forecast'
require_relative '../assets/weather_hash_helper'

module Forecast
  describe Forecast do

    describe "creating a Forecast" do
      it "creates a Location if not initialized with one" do
        Location.should_receive(:new)
        Forecast.new
      end
    end

    let(:location) { double("Location") }
    let(:forecast) { Forecast.new(location) }

    it "can summarize data" do
      expect(forecast).to respond_to(:summary)
    end

    it "knows it's location" do
      expect(forecast.location).to eq location
    end

    describe "getting data from the Forecast Client" do
      let(:client) { double("Client").as_null_object }

      it 'sends a :fetch message to a Client object' do
        client.should_receive(:fetch).with(location)
        forecast.get(client)
      end

      it "recieves the current temp" do
        client.stub(:current_temp) { 32.0 }
        forecast.get(client)
        expect(forecast.current_temp).to eq 32.0
      end

      it "recieves a minutely summary" do
        summary = double
        client.stub(:minutely_summary) { summary }
        forecast.get(client)
        expect(forecast.minutely_summary).to eq summary
      end

      it "recieves an hourly summary" do
        summary = double
        client.stub(:hourly_summary) { summary }
        forecast.get(client)
        expect(forecast.hourly_summary).to eq summary
      end

      it "recieves the probability of rain in the next hour" do
        client.stub(:prob_rain_next_hour) { 0.2 }
        forecast.get(client)
        expect(forecast.prob_rain_next_hour).to eq 0.2
      end

      it "recieves a MinutelyResult object" do
        results = double("MinutelyResult")
        client.stub(:minutely_results) { results }
        forecast.get(client)
        expect(forecast.minutely_results).to eq results
      end
    end

    describe "#rain_next_hour?" do
      it "returns true if there's a reasonable chance of rain" do
        forecast.stub(:prob_rain_next_hour) { 0.4 }
        expect(forecast.rain_next_hour?).to be_true
      end

      it "returns false if miniscule chnace of rain" do
        forecast.stub(:prob_rain_next_hour) { 0.05}
        expect(forecast.rain_next_hour?).to be_false
      end
    end

    describe "finding a window with the lowest precip intensity" do
      it "returns a time range with the lowest" do
        time_range = TimeRange.new(Time.now, Time.now + 5)
        results = double("MinutelyResult")
        results.stub(:least_precip_range).with(10) { time_range }
        forecast.stub(:minutely_results) { results }
        expect(forecast.lowest_precip_intensity_next_hour(10)).to eq time_range
      end
    end
  end
end
