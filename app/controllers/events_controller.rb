class EventsController < ApplicationController

  def show
    @event = Event.find_by(id: params[:id])
  end
end
