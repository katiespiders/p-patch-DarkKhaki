class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:current_user])
  end
  helper_method :current_user

  def admin?
    current_user && current_user.admin
  end
  helper_method :admin?

  def owner?(user)
    current_user == user
  end
  helper_method :owner?

  def authorize_admin
    unless admin?
      redirect_to articles_path, notice: "You are not authorized to do that."
    end
  end

  def authorize_logged_in
    unless current_user
      redirect_to articles_path, notice: "You must be logged in to do that."
    end
  end

  def authorize_owner(user_id)
    unless owner? || admin?
      redirect_to articles_path, notice: "That's not yours"
    end
  end


##### SUPER HACKY WEATHER METHODS
  def weather_helper
    unless current?
      weather = Weather.new
      session[:weather_data] = weather.stored_hash
    end
    weather_hash
  end

  def weather_hash
    session[:weather_data]
  end

  def current?
    if weather_hash
      # puts weather_hash.inspect, "GODDAMNIT ARE YOU FUCKING WITH ME?"
      if weather_hash[:time]
        # puts "NOW IT'S A SYMBOL!"
        weather_hash[:time] > cutoff
      elsif weather_hash["time"] # this is necessary because rails is blatantly just fucking with me
        # puts "NOW IT'S A STRING!"
        weather_hash["time"] > cutoff
      end
    end
  end

  def cutoff
    Time.now - 10.minutes
  end

  def time_string(time)
    if time.class == DateTime
      time.strftime('%l:%M %P')
    elsif time.class == String
      DateTime.parse(time).strftime('%l:%M %P')
    end
  end

  def observation_time # I don't know WTF is happening here. Rails is fucking with me
    if time = weather_helper["time"]
      time_string(time)
    elsif time = weather_helper[:time]
      time_string(time)
    end
  end
  helper_method :observation_time

  def temperature
    weather_helper["temp"]
  end
  helper_method :temperature

  def conditions
    weather_helper["conditions"]
  end
  helper_method :conditions

  def weather_icon
    weather_helper["image"]
  end
  helper_method :weather_icon


end
