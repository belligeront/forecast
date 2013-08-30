require_relative 'forecast/forecast_client'
require_relative 'forecast/forecast_result'
require_relative 'forecast/minutely_result'
require_relative 'forecast/location'
require_relative 'forecast/time_range'
require 'yaml'

module Forecast
  class Forecast

    CONFIG = YAML.load_file('config.yml')
    Lat = CONFIG['latitude']
    Lng = CONFIG['longitude']

    attr_reader :location, :current_temp, :minutely_summary, :hourly_summary,
                :prob_rain_next_hour, :minutely_results

    def initialize(location = nil)
      @location = location || Location.new({latitude: Lat, longitude: Lng})
    end

    def get(client = Client.new)
      result = client.fetch(location)
      @current_temp = result.current_temp
      @minutely_summary = result.minutely_summary
      @hourly_summary = result.hourly_summary
      @prob_rain_next_hour = result.prob_rain_next_hour
      @minutely_results = result.minutely_results
    end

    def rain_next_hour?
      prob_rain_next_hour >= 0.1
    end

    def summary
      puts "#{minutely_summary} #{hourly_summary}"
      puts "Currently #{current_temp.round}F / #{current_temp_celc.round}C."
      if rain_next_hour?
        puts "Ten mins with least rain during next hour: #{print_ten_min_window}."
      end
    end

    def lowest_precip_intensity_next_hour(mins)
      minutely_results.least_precip_range(mins)
    end

    private

    def print_ten_min_window
      lowest_precip_intensity_next_hour(10).readable_string
    end

    def current_temp_celc
      far_to_cel(current_temp)
    end

    def far_to_cel(far)
      (far - 32) * 5 / 9
    end
  end
end
