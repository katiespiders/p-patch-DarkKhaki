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
      "<td><span class='alert'>*</span> #{field_value(obj, field)} #{obj.errors[field].to_sentence}.</td>".html_safe
    end
  end

  private
    def field_value(obj, field)
      params[obj.class.to_s.downcase][field]
    end

end
