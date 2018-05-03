class EventsController < ApplicationController
  before_action :set_event, :only => [ :show, :edit, :update, :destroy]
  def destroy
        @event.destroy
        redirect_to events_url
        flash[:notice] = "event was successfully created"
  end
  def update

        @event.update(event_params)
        redirect_to event_url(@event)
        flash[:notice] = "event was successfully created"
  end
  def edit
  end
  def show
      @page_title = @event.name
      respond_to do |format|
        format.html { @page_title = @event.name } # show.html.erb
        format.xml # show.xml.builder
        format.json { render :json => { id: @event.id, name: @event.name }.to_json }
      end
  end
  def create
      @event = Event.new(event_params)
      if @event.save
      redirect_to events_url
      else
        render :action => :new
      end
      flash[:notice] = "event was successfully created"
  end
  def new
      @event = Event.new
  end
  def index
      @events = Event.page(params[:page]).per(2)
      respond_to do |format|
        format.html # index.html.erb
        format.xml { render :xml => @events.to_xml }
        format.json { render :json => @events.to_json }
        format.atom { @feed_title = "My event list" } # index.atom.builder
      end
  end
  private
  def set_event
      @event = Event.find(params[:id])
  end

  def event_params
      params.require(:event).permit(:name, :description)
  end
end
