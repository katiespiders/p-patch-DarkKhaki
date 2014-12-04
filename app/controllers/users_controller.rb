class UsersController < ApplicationController

  def admin
    authorize_admin
  end

  def new
    @user = User.new
  end

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

  private
    def user_params
      params.require(:user).permit(:username, :email, :email_confirmation, :password, :password_confirmation)
    end

    def authorize_admin
      redirect_to root_path, notice: "Not authorized" unless current_user.admin
    end

end
