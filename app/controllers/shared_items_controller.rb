class SharedItemsController < ApplicationController

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

  def checkout
    redirect_to :library, notice: "noice!"
  end


end
