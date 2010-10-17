class GiftEventsController < ActionController::Base
  respond_to :html, :js
  layout 'application'
  
  def index
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
    @gift_events.each do |gift_event|
      # inject mailer bits
      logger.info "mailed to #{gift_event.gift_admin_email}"
    end
    render
  end
end