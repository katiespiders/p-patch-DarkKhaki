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
      "temp" => temperature
    }
  end

  def url
    "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/conditions/q/WA/Seattle.json"
  end


end
