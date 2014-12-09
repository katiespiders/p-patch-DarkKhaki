class Event < ActiveRecord::Base
  belongs_to :user

  def self.by_date(date)
    self.all.where("start_time < ? AND end_time > ?", date.end_of_day, date.beginning_of_day).order("start_time asc")
  end

  def self.days_in_future(days_later)
    today = Date.today.beginning_of_day
    week_later = today + days_later.days
    all.where("start_time > ? AND start_time < ?", today, week_later)
  end

end
