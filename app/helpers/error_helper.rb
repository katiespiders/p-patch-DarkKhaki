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

  def error_field(obj, field)
    if obj.errors.any? && !obj.errors[field].empty?
      html = "<td><span class='alert'>*</span>"
      if field == :password || field == :password_confirmation
        html += "#{ field == :password ? "Password " : "Password confirmation "} "
      else
        html += "#{field_value(obj, field)}"
      end
      html += "#{obj.errors[field].to_sentence}.</td>"
      html.html_safe
    end
  end

  def password_requirement
    "<td><small>At least 8 characters with 1 digit</small></td>".html_safe
  end

  private
    def field_value(obj, field)
      params[obj.class.to_s.downcase][field]
    end

end
