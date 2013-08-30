require_relative '../../lib/forecast/time_range'

module Forecast
  class MinutelyResult
    attr_reader :data

    def initialize data
      @data = data
    end

    def least_precip_range(duration)
      index = index_of_start_time_with_least_precip(duration)
      start_time = data[index][:time]
      TimeRange.new(start_time, start_time + duration)
    end

    private

    def index_of_start_time_with_least_precip(duration)
      range_of_start_times = (0..(data.count - duration - 1))
      total_precip_by_start_time = range_of_start_times.map do |start_time|
        range = (start_time..(start_time + duration - 1))
        total_precip_for_range(range)
      end
      index_of_minimum_value(total_precip_by_start_time)
    end

    def total_precip_for_range(range)
      range.reduce(0) { |sum, index| sum + data[index][:precipIntensity] }
    end

    def index_of_minimum_value(array)
      array.index(array.min)
    end
  end
end
