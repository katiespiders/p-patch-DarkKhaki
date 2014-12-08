require "httparty"

class Weather

  def initialize
    # need to queue this & also figure out how to display weather while waiting
    @api_hash = HTTParty.get(url)
  end

  def conditions
    weather_data["weather"]
  end

  def temperature
    weather_data["temp_f"]
  end

  def weather_data
    @api_hash["current_observation"]
  end

  def timestamp
    DateTime.parse(weather_data["observation_time_rfc822"])
  end

  def stored_hash
    {
      "time" => timestamp,
      "conditions" => conditions,
      "temp" => temperature,
      "image" => "http://icons.wxug.com/i/c/c/#{conditions_hash[conditions]}"
    }
  end

  def url
    "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/conditions/q/WA/Seattle.json"
  end

  def conditions_hash
    {
      "Chance of Flurries" => "chanceflurries",
      "Chance of Rain" => "chancerain",
      "Chance Rain" => "chancerain",
      "Chance of Freezing Rain" => "chancesleet",
      "Chance of Sleet" => "chancesleet",
      "Chance of Snow" => "chancesnow",
      "Chance of Thunderstorms" => "chancetstorms",
      "Chance of a Thunderstorm" => "chancetstorms",
      "Clear" => "clear",
      "Cloudy" => "cloudy",
      "Flurries" => "flurries",
      "Fog" => "fog",
      "Haze" => "hazy",
      "Mostly Cloudy" => "mostlycloudy",
      "Mostly Sunny" => "mostlysunny",
      "Partly Cloudy" => "partlycloudy",
      "Partly Sunny" => "partlysunny",
      "Freezing Rain" => "sleet",
      "Rain" => "rain",
      "Sleet" => "sleet",
      "Snow" => "snow",
      "Sunny" => "sunny",
      "Thunderstorms" => "tstorms",
      "Thunderstorm" => "tstorms",
      "Overcast" => "cloudy",
      "Scattered Clouds" => "partlycloudy"
    }
  end


end
