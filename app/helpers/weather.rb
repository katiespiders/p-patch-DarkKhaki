require "httparty"

class Weather

  def initialize
    # need to queue this & also figure out how to display weather while waiting
    @sun_hash = HTTParty.get(astronomy_url)["sun_phase"]
    @api_hash = HTTParty.get(weather_url)
    @api_hash["sunrise"] = sun_time("sunrise")
    @api_hash["sunset"] = sun_time("sunset")
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

  def timestamp_date
    timestamp.to_date.to_time
  end

  def sun_time(which)
    hour = @sun_hash[which]["hour"].to_i
    minute = @sun_hash[which]["minute"].to_i
    timestamp_date + hour.hours + minute.minutes
  end

  def daytime?
    puts "*"*80, "sunrise #{@api_hash['sunrise']}, now #{timestamp}, sunset #{@api_hash['sunset']}"
    q = (@api_hash["sunrise"] < timestamp) && (timestamp < @api_hash["sunset"])
    puts "="*80, q
    q
  end

  def stored_hash
    icon = conditions_hash[conditions]
    unless daytime?
      icon = "nt_" + icon
    end

    {
      "time" => timestamp,
      "conditions" => conditions,
      "temp" => temperature,
      "image" => "http://icons.wxug.com/i/c/c/#{icon}"
    }
  end

  def weather_url
    "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/conditions/q/WA/Seattle.json"
  end

  def astronomy_url
    "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/astronomy/q/WA/Seattle.json"
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
