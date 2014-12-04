class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:current_user])
  end
  helper_method :current_user

  def authorize_logged_in
    unless current_user
      redirect_to root_path, notice: "You must be logged in to do that."
    end
  end
end
