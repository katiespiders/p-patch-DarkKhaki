class SharedItemsController < ApplicationController

  def create
    if SharedItem.create_many(params[:name].singularize, params[:quantity].to_i)
      redirect_to :admin, notice: "Your items have been added."
    else
      render "users/admin", notice: "This should be superfluous once we have errors"
    end
  end

end
