class EventsController < ApplicationController
  before_action :find_event, except: [:index, :new]

  def new
    @event = Event.new
  end

  def index
    @upcoming_events = Event.days_in_future(7)  
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to calendar_path, notice: "#{@event.title.capitalize} added to calendar"
    else
      render :new
    end
  end

  private
    def event_params
      data = params.require(:event).permit(:title, :description, :start_date, :end_date, :start_time, :end_time)
      {
        title: data[:title],
        description: data[:description],
        start_time: parse_datetime(data[:start_date], data[:start_time]),
        end_time: parse_datetime(data[:end_date], data[:end_time])
      }
    end

    def find_event
      @event = Event.find_by(id: params[:id])
    end

    def parse_datetime(date, time)
      DateTime.parse(date + " " + time + "-800")
    end

end
