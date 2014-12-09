module EventsHelper

  def make_day(date)
    Day.new(date).box
  end

  def make_month(date)
  Calendar.new(date.month, date.year).make_days
  end

  class Calendar

    def initialize(month, year)
      @month = month
      @year = year
      @day_num = Time.days_in_month(@month, year)
    end

    def make_days
      html = (1..@day_num).collect do |day|
        Day.new(Date.parse("#{@year}-#{@month}-#{day}")).box
      end
      html.join('').html_safe
    end

  end

  class Day

    def initialize(date)
      @date = date
    end

    def box
      html = """
      <div class= \"day_box\">
        #{@date.day}
      </div>
      """
      html.html_safe
    end

  end

end
