require "api_cache"
require "json"

class Weather

  def initialize
    @sun_hash = JSON.parse(APICache.get(astronomy_url))["sun_phase"]
    @current_hash = JSON.parse(APICache.get(weather_url))
    @current_hash["sunrise"] = sun_time("sunrise")
    @current_hash["sunset"] = sun_time("sunset")

    @forecast_hash = JSON.parse(APICache.get(forecast_url))["forecast"]["simpleforecast"]["forecastday"]
  end

  def weather_data
    @current_hash["current_observation"]
  end

  def conditions
    weather_data["weather"]
  end

  def temperature
    weather_data["temp_f"].to_i.round
  end

  def timestamp
    DateTime.parse(weather_data["observation_time_rfc822"])
  end

  def timestamp_date
    timestamp.to_date.to_time
  end

  def sun_time(sun_phase)
    hour = @sun_hash[sun_phase]["hour"].to_i
    minute = @sun_hash[sun_phase]["minute"].to_i
    timestamp_date + hour.hours + minute.minutes
  end

  def daytime?
    puts "*"*80, "sunrise #{@current_hash['sunrise']}, now #{timestamp}, sunset #{@current_hash['sunset']}"
    q = (@current_hash["sunrise"] < timestamp) && (timestamp < @current_hash["sunset"])
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

  def forecast_array
    forecast_array = []
    @forecast_hash.each do |forecast|
      forecast_array << {
        date: Time.at(forecast['date']['epoch'].to_i),
        conditions: forecast['conditions'],
        image: "http://icons.wxug.com/i/c/c/#{forecast['icon']}"
      }
    end
    forecast_array
  end


  def weather_url
    "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/conditions/q/WA/Seattle.json"
  end

  def astronomy_url
    "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/astronomy/q/WA/Seattle.json"
  end

  def forecast_url
    "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/forecast10day/q/WA/Seattle.json"
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
