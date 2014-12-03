class SharedItemsController < ApplicationController

  def create
    @item = SharedItem.create_many(params[:name].singularize, params[:quantity].to_i)
    # create many returns the item with errors if it is unsuccessful
    # otherwise it return quanitity
    if defined? @item.errors
      render "users/admin"
    else
      flash[:notice] = "Your items have been added." if @item != 0 
      redirect_to :admin
    end
  end

end
