module EventsHelper

  def make_day(date)
    Day.new(date).box
  end

  def display_calendar(date)
    Cal.new(date.month, date.year).table
  end

  class Cal

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
          <tr> <th colspan='7'> #{Date::MONTHNAMES[@month]} </th> </tr>
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
        </div>
      </td>
      """
      html.html_safe
    end

  end

end
