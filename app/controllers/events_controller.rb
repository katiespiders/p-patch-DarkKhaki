class EventsController < ApplicationController
  before_action :find_event, except: [:index, :new]
  before_action only: [:update, :destroy] do
    authorize_owner(session[:current_user])
  end

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

  def update
    @event.update(event_params)
    if @event.save
      redirect_to calendar_path, notice: "#{@event.title.capitalize} has been edited"
    else
      render :edit
    end
  end

  def destroy
    title = @event.title.capitalize
    @event.destroy
    redirect_to calendar_path, notice: "#{title} has been deleted"
  end

  private
    def event_params
      data = params.require(:event).permit(:title, :description, :start_date, :end_date, :start_time, :end_time)
      {
        title: data[:title],
        description: data[:description],
        start_time: parse_datetime(data[:start_date], data[:start_time]),
        end_time: parse_datetime(data[:end_date], data[:end_time]),
        user_id: session[:current_user]
      }
    end

    def find_event
      @event = Event.find_by(id: params[:id])
    end

    def parse_datetime(date, time)
      DateTime.parse(date + " " + time + "-800")
    end

end
