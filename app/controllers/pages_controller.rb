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
    @week_events = Event.days_in_future(7)
    @month_events = Event.in_month(Date.today)
    @articles = Article.all.order("created_at desc").take(3)
  end

end
