class GiftEventContributionsController < ApplicationController
  respond_to :html, :js

  def create
    @gift_event = GiftEvent.find_by_access_token(params[:event_id])
    return render :template => 'gift_events/not_found' if @gift_event.nil?

    @contribution = Contribution.new(params[:contribution])
    @gift_event.contributions << @contribution
    respond_to do |format|
      if @contribution.valid? and @gift_event.save
        @gift_event.reload
        format.html { redirect_to event_url(@gift_event.access_token) }
        format.js { render :action => :create}
      else
        format.html { respond_with(@gift_event)}
      end
    end
  end
  
end
    