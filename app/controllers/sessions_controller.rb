class SessionsController < ApplicationController

  def create
    if user = User.find_by(username: username)
      if user.authenticate(password)
        session[:current_user] = user.id
        flash[:notice] = "Hi, #{user.username}!"
        redirect_to root_path
      else
        raise "wrong password"  # make this a real error
      end
    else
      raise "you don't exist"   # make this a real error
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
