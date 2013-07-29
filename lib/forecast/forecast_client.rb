require 'json'
require 'open-uri'
require 'yaml'

# hash[:minutely][:summary] #drizzle in 30 min
# hash[:minutely][:data] # array with 61 elements (60 mintues) - [0] is the current minute
# hash[:minutely][:data][60][:precipIntensity]
# hash[:minutely][:data][60][:precipIntensityError]
# hash[:minutely][:data][60][:precipProbability]
# hash[:minutely][:data][60][:precipType] #ie rain

# hash[:hourly][:summary] # "rain later this evening
# hash[:hourly][:data] # "array with 49 elements (48 hours) - [0] is X:00 of the prev hour
# hash[:hourly][:data] # "rain later this evening

module Forecast
  class Client
    API_KEY = YAML.load_file('config.yml')['forecast_io_api_key']

    attr_reader :latitude, :longitude

    def fetch(location)
      @latitude = URI.escape(location.latitude.to_s)
      @longitude = URI.escape(location.longitude.to_s)
      parse_json(raw_json)
    end

    private


    def uri
      "#{uri_endpoint}#{api_key}/#{latitude},#{longitude}"
    end

    def api_key
      URI.escape API_KEY
    end

    def raw_json
      open(uri).read
    end

    def parse_json json
      JSON.parse(json, {symbolize_names: true})
    end

    def uri_endpoint
      "https://api.forecast.io/forecast/"
    end
  end
end
