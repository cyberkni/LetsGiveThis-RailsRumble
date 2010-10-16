class Planner::GiftEventsController < ActionController::Base
  respond_to :html
  
  def new
    @gift_event = GiftEvent.new
    respond_with(@gift_event)
  end
  
  def create
    @gift_event = GiftEvent.new(params[:gift_event])
    respond_to do |format|
      if @gift_event.save
        @gift_event.reload
        format.html { redirect_to event_url(@gift_event.access_token) }
      else
        format.html { render :action => 'new' }
      end
    end
  end
  
end
