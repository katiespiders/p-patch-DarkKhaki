module ErrorHelper

  def error_message(obj)
    if obj.errors.any?
      html =  "<ul class='error_messages'>"
      obj.errors.each do |column_name, message|
        html += "<li> <strong>" + column_name.to_s.capitalize + "</strong> " + message + "</li>"
      end
      html += "</ul>"
      html.html_safe
    end
  end


end
