class Planner::GiftEventsController < ActionController::Base
  respond_to :html, :js
  layout 'application'
  
  def new
    @gift_event = GiftEvent.new
    respond_with(@gift_event)
  end

  def show
    @gift_event = GiftEvent.find_by_gift_admin_token(params[:id])
    if @gift_event
      respond_with(@gift_event)
    else
      render :action => 'not_found'
    end
  end

  def create
    @gift_event = GiftEvent.new(params[:gift_event])
    respond_to do |format|
      if @gift_event.save
        @gift_event.reload
        Notifier.send_gift_event_admin_info(@gift_event).deliver
        logger.info "mailed initial info to #{@gift_event.gift_admin_email}"
        format.html { redirect_to planner_event_url(@gift_event.gift_admin_token) }
        format.js { respond_with(@gift_event) }
      else
        format.html { render :action => 'index' }
        format.js { render :json => @gift_event.errors }
      end
    end
  end

  def edit
    @gift_event = GiftEvent.find_by_gift_admin_token(params[:id])
    respond_with(@gift_event)
  end

  def update
    @gift_event = GiftEvent.find_by_gift_admin_token(params[:id])
    respond_to do |format|
      if @gift_event.update_attributes(params[:gift_event])
        @gift_event.reload
        format.html { redirect_to planner_event_url(@gift_event.gift_admin_token) }
        format.js { render :action => :create }
      else
        format.html { render :action => 'edit' }
        format.js { render :action => 'edit' }
      end
    end
  end

end
