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


end
