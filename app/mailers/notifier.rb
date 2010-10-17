class Notifier < ActionMailer::Base
  default :from => "no-reply@letsgivethis.com"
  
  def over_the_line(gift_event)
    @gift_event = gift_event
    mail(:to => gift_event.gift_admin_email, :subject => "You're Over The Line!")
  end
  
  def resend_admin_link(gift_event)
    @gift_event = gift_event
    mail(:to => gift_event.gift_admin_email, :subject => "Your forgotten Let's Give This link!")
  end
  
end
