class SharedItemsController < ApplicationController
  before_filter :authorize_logged_in, only: :checkout
  before_filter :authorize_admin, only: :confirm_return

  def index
    @item_hash = SharedItem.available_item_hash
  end

  def create
    @item = SharedItem.create_many(params[:name].singularize, params[:quantity].to_i)
    # create many returns the item with errors if it is unsuccessful
    # otherwise it return quanitity
    if defined? @item.errors
      render "users/admin"
    else
      redirect_to :admin, notice: "Your items have been added."
    end
  end

  def confirm_return
    item = SharedItem.find(params[:shared_item][:id])
    item.update(params.require(:shared_item).permit(:user_id, :pending, :due))
    redirect_to :admin
  end

  #good candidate for Ajax!
  def set_pending
    item = SharedItem.find_by(name: params[:name], user_id: params[:user_id])
    item.update(pending: true)
    redirect_to User.find(params[:user_id])
  end

  def checkout
    item = SharedItem.find_by(name: params[:name], user_id: nil)
    item.update(user_id: current_user.id, due: Date.today+7.days)
    # this part will change when we do ajax!
    redirect_to :library, notice: "#{item.name.capitalize} has been checked out."
  end


end
