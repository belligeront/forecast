module Forecast
  class TimeRange
    attr_reader :start_time, :end_time

    def initialize(start_time = Time.now, end_time)
      @start_time = start_time
      @end_time = end_time
    end

    def duration
      ((end_time.to_i - start_time.to_i) / 60.0).round
    end
  end
end
