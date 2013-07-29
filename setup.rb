require 'open-uri'
require 'json'

class Setup
  attr_reader :address, :data

  def run
    puts "Enter a forecast location:"
    @address = replace_spaces_and_escape(gets.chomp)
    @data = JSON.parse(raw_json)
    write_lat_and_lgn_to_config
    puts "Writing lat and long to config.yml"
  end

  private

  def raw_json
    open(uri).read
  end

  def uri
    "http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false"
  end

  def replace_spaces_and_escape(user_input)
    URI.escape(replace_spaces_with_commas(user_input))
  end

  def replace_spaces_with_commas(user_input)
    user_input.gsub(/(,\s+|\s+)/, ",")
  end

  def write_lat_and_lgn_to_config
    File.open("config.yml", "a+") do |f|
      f.puts example_api_key unless f.read.match(/forecast_io_api_key/)
      f.puts latitude
      f.puts longitude
    end
  end

  def latitude
    "latitude: #{data['results'].first['geometry']['location']['lat']}"
  end

  def longitude
    "longitude: #{data['results'].first['geometry']['location']['lng']}"
  end

  def example_api_key
    "forecast_io_api_key: \"xxxxxxxxxxxx\""
  end
end

Setup.new.run
