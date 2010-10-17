class GiftEventContributionsController < ApplicationController
  respond_to :html, :js

  def create
    @gift_event = GiftEvent.find_by_access_token(params[:event_id])
    render :status => 404 if @gift_event.nil?
    @contribution = Contribution.new(params[:contribution])
    @gift_event.contributions << @contribution
    respond_to do |format|
      if @contribution.valid? and @gift_event.save
        format.html { redirect_to event_url(@gift_event.access_token) }
        format.js { render :action => :create}
      else
        format.html { render :status => 502}
      end
    end
  end
  
end
    