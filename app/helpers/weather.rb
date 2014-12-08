require "httparty"

class Weather

  def initialize
    url = "http://api.wunderground.com/api/#{ENV['WUNDERGROUND_API_KEY']}/conditions/q/WA/Seattle.json"
    @weather = HTTParty.get(url)
  end

  def conditions
    @weather["current_observation"]["weather"]
  end
end
