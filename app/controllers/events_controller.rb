class EventsController < ApplicationController

  def index
    @upcoming_events = Event.days_in_future(7)  
  end

  def show
    @event = Event.find_by(id: params[:id])
  end
end
