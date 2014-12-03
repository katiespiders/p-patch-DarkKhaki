class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user] = @user.id
      flash[:notice] = "Welcome to B-Patch, #{@user.username}!"
      redirect_to root_path
    else
      flash[:notice] = "Fail" # this doesn't work for render, fix it
      render :new
    end
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
