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
  
end