class PagesController < ApplicationController

  def landing
    if current_user
      redirect_to :articles
    else
      redirect_to :about
    end
  end

  def about
    render 'shared/about', layout: false
  end
end
