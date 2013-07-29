Forecast
========

Forecast delivers weather information to your terminal.

Heading out into the rain soon? Forecast will tell you the best time to go.

### Setup
1. Clone the repo:    `git clone https://github.com/belligeront/forecast.git`
2. Run Bundler:    `bundle install`
3. Run setup:   `ruby setub.rb`
4. Enter a forecast location at the prompt. Setup will save your Latitude and Longitude files to a config file.
3. Get a [forecast.io API key](https://developer.forecast.io).
4. Open config.yml and enter your API key into the placeholder:     `forecast_io_api_key: "************"`
5. Make bin/forecast executable: `chmod +x bin/forecast`
6. Run forecast.  `bin/forecast`

