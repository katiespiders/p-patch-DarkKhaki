class Event < ActiveRecord::Base
  belongs_to :user

  def self.by_date(date)
    self.all.where("start_time < ? AND end_time > ?", date.end_of_day, date.beginning_of_day).order("start_time asc")
  end

end
