require_relative 'forecast/forecast_client'
require_relative 'forecast/location'
require_relative 'forecast/time_range'
require 'yaml'

module Forecast
  class Forecast

    CONFIG = YAML.load_file('config.yml')
    Lat = CONFIG['latitude']
    Lng = CONFIG['longitude']

    attr_reader :location

    def initialize(location = nil)
      @location = location || Location.new({latitude: Lat, longitude: Lng})
    end

    def get(client = Client.new)
      @data = client.fetch(location)
    end

    def summary
      puts "Currently #{current_temp.round}F / #{current_temp_celc.round}C"
      puts "#{minutely_summary} #{hourly_summary}"
      if rain_in_next_hour?
        puts "Ten minutes with least rain during the next hour: #{print_ten_min_window}."
      end
    end

    private

    def rain_in_next_hour?
      hourly_data[0][:precipProbability] > 0.1
    end

    def minutely_summary
      @data[:minutely][:summary]
    end

    def hourly_summary
      @data[:hourly][:summary]
    end

    # Returns array with 61 elements (60 mintues) - [0] is the current minute
    def minutely_data
      @data[:minutely][:data]
    end

    # Returns array with 49 elements (48 hours) - [0] is the current hour
    def hourly_data
      @data[:hourly][:data]
    end

    def print_ten_min_window
      range = find_range_in_next_hour_with_lowest_precip(10)
      "#{format_time(range.start_time)} - #{format_time(range.end_time)}"
    end

    def format_time(time)
      time.strftime("%l:%M %P")
    end

    def find_range_in_next_hour_with_lowest_precip(mins)
      index = index_of_starting_minute_with_lowest_precip_intensity(mins)
      staring_time = minutely_data[index][:time]
      TimeRange.new(Time.at(staring_time), Time.at(staring_time + mins * 60))
    end

    def index_of_starting_minute_with_lowest_precip_intensity(mins)
      precip_by_start_minute = (0..60 - mins).map do |starting_min|
        range = (starting_min..starting_min + mins)
        minutely_data[range].reduce(0) { |sum, minute| sum + minute[:precipIntensity] }
      end
      index_of_min_value(precip_by_start_minute)
    end

    def index_of_min_value(arr)
      arr.index(arr.min)
    end

    def current_temp
      @data[:currently][:temperature]
    end

    def current_temp_celc
      far_to_cel(current_temp)
    end

    def far_to_cel(far)
      (far - 32) * 5 / 9
    end
  end
end
