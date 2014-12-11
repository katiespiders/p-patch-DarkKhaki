module EventsHelper

  def make_day(date)
    Day.new(date).box
  end

  def display_calendar(date)
    Calendar.new(date.month, date.year).table
  end

  def pretty_event_time(event)
    start = event.start_time
    finish = event.end_time

    html = "#{pretty(start)}"

    if start.to_date == finish.to_date
      html += " until #{pretty(finish)[-7]}"
    else
      html += " to #{pretty(finish)}"
    end

    html.html_safe
  end

  def pretty(time)
    time.strftime('%a, %b %e at %l:%M %P')
  end

  # def pretty_event_time(event)
  #   start_hash = time_attr_hash(event.start_time)
  #   finish_hash = time_attr_hash(event.end_time)
  #   html ="""
  #         #{start_hash[:wkday]}, #{start_hash[:month]} #{start_hash[:day_num]}
  #         #{start_hash[:hour]}:#{start_hash[:minute]} #{start_hash[:meridian]}
  #         """
  #   if event.start_time.to_date == event.end_time.to_date
  #     html += "- #{finish_hash[:hour]}:#{finish_hash[:minute]} #{finish_hash[:meridian]}"
  #   else
  #     html += "#{finish_hash[:wkday]}, #{finish_hash[:month]} #{finish_hash[:day_num]} - #{finish_hash[:hour]}: #{finish_hash[:minute]} #{finish_hash[:meridian]}"
  #   end
  #   puts "*"*80, html
  #   html.html_safe
  # end
  #
  # def time_attr_hash(date)
  #   pieces = { wkday: "%a", month: "%b", day_num: "%e", hour: "%l", minute: "%M", meridian: "%P" }
  #   time_hash = {}
  #   pieces.each do |attribute, access_code|
  #     time_hash[attribute] = date.strftime(access_code)
  #   end
  #   return time_hash
  # end

  class Calendar

    def initialize(month, year)
      @month = month
      @year = year
      @day_num = Time.days_in_month(@month, year)
    end

    ### This is an array of day objects
    def make_days
      month = (1..@day_num).collect do |day|
        Day.new(Date.parse("#{@year}-#{@month}-#{day}"))
      end

      month[0].date.wday.times { month.insert(0, Day.new(Date.new))}
      month
    end

    ### These generate html
    def make_week(day_array, week_num)
      day_num = (week_num-1) * 7

      week_array = day_array[day_num...day_num + 7]
      week_array.collect! { |day| day.box }
      array_to_html(week_array)
    end

    def make_weeks(day_array)
      week_array= (1..5).collect do |week_num|
        "<tr>" + make_week(day_array, week_num) + "</tr>"
      end
      array_to_html(week_array)
    end

    def array_to_html(array)
      array.join('').html_safe
    end

    def table
      """
        <table>
          <tr> <th colspan='7'> <h3> #{Date::MONTHNAMES[@month]}<h3> </th> </tr>
          <tr> #{days_of_week} </tr>
          #{make_weeks(make_days)}

        </table>
      """.html_safe
    end

    def days_of_week
      days = Date::ABBR_DAYNAMES
      day_array = days.collect do |day|
        """
          <th>
            #{day}
          </th>
        """
      end
      array_to_html(day_array)
    end

  end

  class Day
    attr_accessor :date

    def initialize(date)
      @date = date
    end

    def box
      html = """
      <td>
        <div class= \"day_box\">
          #{@date.year > 0 ? @date.day : ""}
          #{events_html(@date)}
        </div>
      </td>
      """
      html.html_safe
    end

    def events_html(date)
      html = "<ul>"
      Event.by_date(date).each do |event|
        html += "<li><a href='events/#{event.id}'>#{event.title}</a></li>"
      end
      html += "</ul>"
      html.html_safe
    end
  end
end
