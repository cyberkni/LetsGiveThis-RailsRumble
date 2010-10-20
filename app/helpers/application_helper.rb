module ApplicationHelper
  def controller_action_style
    @action_style ||= "#{controller.controller_name}_#{controller.action_name}"
  end

  def add_optional_page_stylesheet
    style_file = controller_action_style
    style_file_path = Rails.root + ('public/stylesheets/' + style_file + '.css')
    if style_file_path.exist?
      stylesheet_link_tag style_file
    end
  end

  def show_flash_messages
    ret_val = ''
    if flash[:notice]
      ret_val += "<div class=\"notice\"><p class=\"success\">#{flash[:notice]}</p></div>"
    end
    if flash[:error]
      ret_val += "<div class=\"notice\"><p class=\"success\">#{flash[:error]}</p></div>"
    end
    return ret_val
  end
end
