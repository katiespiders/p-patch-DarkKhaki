module EventsHelper

  def make_day(date)
    Day.new(date).box
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
