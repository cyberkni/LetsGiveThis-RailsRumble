class GiftEventsController < ActionController::Base
  respond_to :html, :js
  layout 'application'
  
  def index
    @gift_event = GiftEvent.new
    render :action => 'index'
  end
  
  def show
    @gift_event = GiftEvent.find_by_access_token(params[:id])
    if @gift_event
      @contribition = Contribution.new
      render
    else
      render :action => 'not_found'
    end
  end
  
  def admin_recovery
    @gift_events = GiftEvent.find_all_by_gift_admin_email(params[:admin_email])
    unless @gift_events.blank?
      Notifier.resend_admin_link(@gift_events).deliver
      logger.info "mailed to #{@gift_events.first.gift_admin_email}"
    end
    redirect_to('/', {:notice => 'We just dispatched the email explaining how to manage your group gift.'})
  end
end