module Forecast
  class TimeRange
    attr_reader :start_time, :end_time

    def initialize(start_time = Time.now, end_time)
      @start_time = convert_numerics_to_time(start_time)
      @end_time = convert_numerics_to_time(end_time)
    end

    def duration
      ((end_time.to_i - start_time.to_i) / 60.0).round
    end

    def readable_string
      [format_time(start_time), format_time(end_time)].join(" - ")
    end

    private

    def convert_numerics_to_time(time)
      if time.is_a?(Numeric)
        time = Time.at(time)
      end
      time
    end

    def format_time(time)
      time.strftime("%l:%M %P")
    end
  end
end
