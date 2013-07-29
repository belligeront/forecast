Forecast
========

Forecast delivers weather information to your terminal. Heading out into the rain soon? Forecast will tell you the best time to go.

### Setup
1. Clone the repo:    `git clone https://github.com/verg/forecast.git`
2. Run setup:   `ruby setub.rb`
3. Enter a forecast location at the prompt. Setup will save your Latitude and Longitude files to `config.yml`
4. Get a [forecast.io API key](https://developer.forecast.io/register).
5. Open config.yml and enter your API key into the placeholder:     `forecast_io_api_key: "************"`
6. Make forecast executable: `chmod +x bin/forecast`
7. Run forecast.  `bin/forecast`
