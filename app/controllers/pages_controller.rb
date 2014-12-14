class PagesController < ApplicationController

  def landing
    if current_user
      redirect_to :home
    else
      redirect_to :about
    end
  end

  def about
    render 'shared/about', layout: false
  end

  def home
    @upcoming_events = Event.days_in_future(7)
  end

end
