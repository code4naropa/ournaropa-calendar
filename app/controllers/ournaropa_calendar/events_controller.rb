require_dependency "ournaropa_calendar/application_controller"

module OurnaropaCalendar
  class EventsController < ::ApplicationController
    
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    # inherit the layout from the main application
    layout 'application'
    
    require "time"
    require 'chronic'
    
    # for important functions
    include EventsHelper
    
    # if wrong id
    rescue_from ActiveRecord::RecordNotFound do |exception|
      render 'not_found'
    end

    # GET /events
    def index
      
      @show_date = params[:date].present? ? Date.strptime(params[:date], "%b+%Y").to_time : Time.zone.now
      
      @events = Event.relevant({start: get_calendar_start_date(@show_date), end: get_calendar_end_date(@show_date)})
      
      # parse to days
      @events_by_day = Hash.new
      
      @events.each do |event|
        for i in 0..event.duration_in_days do
          
          # if no events have been saved for this day yet, then create it
          if @events_by_day[(event.start_time + i.day).strftime("%Y-%m-%d").to_s].nil?
            @events_by_day[(event.start_time + i.day).strftime("%Y-%m-%d").to_s] = []
          end
            
          @events_by_day[(event.start_time + i.day).strftime("%Y-%m-%d").to_s].push(event)
        end
      end
    end

    # GET /events/1
    def show
      if @event.nil?
        puts "lol"
      end
    end

    # GET /events/new
    def new
      @event = Event.new
    end

    # GET /events/1/edit
    def edit
      redirect_to @event, notice: "Cannot edit event: The link you provided does not match the event's key code." unless @event.edit_code == params[:edit_code]
    end

    # POST /events
    def create      
      @event = Event.new(event_params)


      if @event.save
        redirect_to @event, flash: { show_edit_code: true }
      else
        render :new
      end
    end

    # PATCH/PUT /events/1
    def update
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /events/1
    def destroy
      
      redirect_to @event, notice: "Cannot delete event: The link you provided does not match the event's key code." unless @event.edit_code == params[:edit_code]
      
      @event.destroy
      redirect_to root_url, notice: 'Event was successfully deleted.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def event_params
        params.require(:event).permit(:title, :description, :start_time_text, :start_time, :end_time_text, :end_time, :location, :organizer_name, :organizer_email)
      end
  end
end
