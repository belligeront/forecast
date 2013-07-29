require 'geocoder'

unless File.exist?("config.yml")
  puts "Creating config.yml"
  File.open("config.yml", "w") do |f|
    f.puts "forecast_io_api_key: \"xxxxxxxxxxxx\""
  end
end

puts "Enter a forecast location:"

response = Geocoder.search(gets.chomp)
lat = response.first.data['geometry']['location']['lat']
lng = response.first.data['geometry']['location']['lng']

File.open("config.yml", "a") do |f|
  f.puts "latitude: #{lat}"
  f.puts "longitude: #{lng}"
end
puts "Writing lat and long to config.yml"
