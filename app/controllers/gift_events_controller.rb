class GiftEventsController < ActionController::Base
  respond_to :html
  
  def index
    render :action => 'index'
  end
  
  def show
    @gift_event = GiftEvent.find(:params[:id])
    respond_with(@gift_event)
  end
  
end