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

  def self.in_month(day)
    first = day.beginning_of_month
    last = day.end_of_month
    where("start_time BETWEEN ? AND ? OR end_time BETWEEN ? AND ?", first, last, first, last) + where("start_time < ? AND end_time > ?", first, last)
  end

  def start_date_default
    start_time ? start_time.to_date : Date.today
  end

  def end_date_default
    end_time ? end_time.to_date : Date.today
  end

  def start_time_default
    start_time ? start_time.strftime('%H:%M') : '11:00'
  end

  def end_time_default
    end_time ? end_time.strftime('%H:%M') : '15:00'
  end
end
