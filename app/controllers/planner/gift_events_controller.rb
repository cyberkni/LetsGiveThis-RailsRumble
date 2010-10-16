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
        format.html { redirect_to(@gift_event) }
      else
        format.html { render :action => 'new' }
      end
    end
  end
  
end
