require_dependency "ournaropa_calendar/application_controller"

module OurnaropaCalendar
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    require "time"
    require 'chronic'
    
    # for important functions
    include EventsHelper
    
    # GET /events
    def index
      
      @show_date = params[:date].present? ? Date.strptime(params[:date], "%b+%Y").to_time : Time.now
      
      @events = Event.relevant({start: get_calendar_start_date(@show_date), end: get_calendar_end_date(@show_date)})
    end

    # GET /events/1
    def show
    end

    # GET /events/new
    def new
      @event = Event.new
    end

    # GET /events/1/edit
    def edit
    end

    # POST /events
    def create      
      @event = Event.new(event_params)


      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
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
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully destroyed.'
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
