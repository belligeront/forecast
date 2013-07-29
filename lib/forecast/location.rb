module Forecast
  class Location

    attr_accessor :latitude, :longitude

    def initialize params
      @latitude = params[:latitude]
      @longitude = params[:longitude]
    end
  end
end
