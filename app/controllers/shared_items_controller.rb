class SharedItemsController < ApplicationController
  before_filter :authorize_logged_in, only: :checkout

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

  #good candidate for Ajax!
  def update
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
