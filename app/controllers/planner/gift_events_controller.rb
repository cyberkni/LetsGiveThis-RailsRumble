class Planner::GiftEventsController < ActionController::Base
  respond_to :html, :js
  
  def new
    @gift_event = GiftEvent.new
    respond_with(@gift_event)
  end
  
  def show
    @gift_event = GiftEvent.find_by_gift_admin_token(params[:id])
    respond_with(@gift_event)
  end
  
  def create
    @gift_event = GiftEvent.new(params[:gift_event])
    respond_to do |format|
      if @gift_event.save
        @gift_event.reload
        format.html { redirect_to planner_event_url(@gift_event.gift_admin_token) }
        format.js { respond_with(@gift_event) }
      else
        format.html { render :action => 'new' }
        format.js { render :action => 'new' }
      end
    end
  end
  
end
