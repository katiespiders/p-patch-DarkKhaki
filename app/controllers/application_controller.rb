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

  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?

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
    unless owner?(User.find(user_id)) || admin?
      redirect_to articles_path, notice: "That's not yours"
    end
  end

##### NOT SO HACKY WEATHER METHODS
  def weather_helper
    Weather.new.stored_hash
  end

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

  def forecast_helper
    Weather.new.forecast_array
  end

  def forecast_date(index)
    forecast_helper[index][:date]
  end
  helper_method :forecast_date

  def forecast_conditions(index)
    f=forecast_helper[index][:conditions]
  end
  helper_method :forecast_conditions

  def forecast_icon(index)
    forecast_helper[index][:image]
  end
  helper_method :forecast_icon
end
