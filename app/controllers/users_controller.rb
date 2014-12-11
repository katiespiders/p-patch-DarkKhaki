class UsersController < ApplicationController
  before_filter :authorize_admin, only: [ :admin, :make_admin, :index ]
  before_filter :authorize_logged_in, only: :show
  before_filter :authorize_account_exists, only: :show

  def admin
    @pending_items = SharedItem.where(pending: true)
  end

  def make_admin
    user = User.find(params[:user])
    user.update(admin: true)
    redirect_to user
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @items = SharedItem.users_items_array(@user).sort_by { |array| array[1] }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user] = @user.id
      flash[:notice] = "Welcome to B-Patch, #{@user.username}!"
      redirect_to root_path
    else
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

    def authorize_account_exists
      redirect_to root_path, notice: "Account not found" unless User.find_by(id: params[:id])
    end

end
