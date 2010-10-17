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
end
