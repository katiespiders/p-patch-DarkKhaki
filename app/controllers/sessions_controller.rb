class SessionsController < ApplicationController

  def create
    flash[:notice] = []
    if user = User.find_by(username: username)
      if user.authenticate(password)
        session[:current_user] = user.id
        flash[:notice] = "Hi, #{username}!"
        redirect_to root_path
      else
        flash[:notice] = { password: "Wrong password :(" }
        render :new
      end
    else
      flash[:notice] = { username: "#{username} is not a registered user" }
      render :new
    end
  end

  def destroy
    username = User.find(session[:current_user]).username
    session[:current_user] = nil
    redirect_to root_path, notice: "Later, #{username}!"
  end

  private
    def username
      session_params[:username]
    end

    def password
      session_params[:password]
    end

    def session_params
      params.require(:user).permit(:username, :password)
    end
end
