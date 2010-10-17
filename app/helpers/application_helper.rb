module ApplicationHelper
  def controller_action_style
    @action_style ||= "#{controller.controller_name}_#{controller.action_name}"
  end
end
