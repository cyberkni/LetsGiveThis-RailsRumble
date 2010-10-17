class GiftEventsController < ActionController::Base
  respond_to :html, :js
  layout 'application'
  def index
    render :action => 'index'
  end
  
  def show
    @gift_event = GiftEvent.find_by_access_token(params[:id])
    @contribition = Contribution.new
    render
  end
  
  def admin_recovery
    @gift_events = GiftEvent.find_all_by_gift_admin_email(params[:admin_email])
    Notifier.resend_admin_link(@gift_events)
    logger.info "mailed to #{gift_events.first.gift_admin_email}"
    render
  end
end