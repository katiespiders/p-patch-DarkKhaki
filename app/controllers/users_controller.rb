class UsersController < ApplicationController
  before_filter :authorize_admin, only: :admin
  before_filter :authorize_logged_in, only: :show

  def admin
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to root_path, notice: "Account not found" unless @user
    @items = SharedItem.users_items_array(@user).sort_by { |array| array[1] }
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
      unless current_user && current_user.admin
        redirect_to root_path, notice: "Not authorized"
      end
    end

end
