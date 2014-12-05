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

  # refactor all this bs
  def error_field(obj, field)
    if obj.errors.any? && !obj.errors[field].empty?
      html = alert
      if field == :password || field == :password_confirmation
        html += "#{ field == :password ? "Password " : "Password confirmation "} "
      else
        html += "#{field_value(obj, field)}"
      end
      html += "#{obj.errors[field].to_sentence}.</td>"
      html.html_safe
    end
  end

  def title_error(obj)
    (alert + "Title #{obj.errors[:title].to_sentence}").html_safe unless obj.errors[:title].empty?
  end

  def content_error(obj)
    (alert + "Content #{obj.errors[:content].to_sentence}").html_safe unless obj.errors[:content].empty?
  end

  def password_requirement
    "<td><small>At least 8 characters with 1 digit</small></td>".html_safe
  end

  private
    def field_value(obj, field)
      params[obj.class.to_s.downcase][field]
    end

    def alert
      "<td><span class='alert'>*</span>"
    end
end
