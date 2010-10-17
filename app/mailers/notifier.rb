class Notifier < ActionMailer::Base
  default :from => "no-reply@letsgivethis.com"
  
  def over_the_line(gift_event)
    @gift_event = gift_event
    mail(:to => @gift_event.gift_admin_email, :subject => "You're Over The Line!") do |format|
      format.text { render "over_the_line" }
    end
  end
  
  def resend_admin_link(gift_events)
    @gift_events = gift_events
    @admin_email = @gift_events.first.gift_admin_email
    @links = ''
    @gift_events.map do |event|
      @links += "#{event.gift_name} - http://www.letsgivethis.com/planner/event/#{event.gift_admin_token}\n"
    end
    mail(:to => @gift_events.first.gift_admin_email, :subject => "Your forgotten Let's Give This info!") do |format|
      format.text { render "resend_admin_link" }
    end
  end
  
end
