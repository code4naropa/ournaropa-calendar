require 'test_helper'

module OurnaropaCalendar
  class EventsControllerTest < ActionController::TestCase
    setup do
      @event = ournaropa_calendar_events(:one)
      @routes = Engine.routes
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:events)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create event" do
      assert_difference('Event.count') do
        post :create, event: { description: @event.description, end: @event.end, location: @event.location, organizer_email: @event.organizer_email, organizer_name: @event.organizer_name, start: @event.start, title: @event.title }
      end

      assert_redirected_to event_path(assigns(:event))
    end

    test "should show event" do
      get :show, id: @event
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @event
      assert_response :success
    end

    test "should update event" do
      patch :update, id: @event, event: { description: @event.description, end: @event.end, location: @event.location, organizer_email: @event.organizer_email, organizer_name: @event.organizer_name, start: @event.start, title: @event.title }
      assert_redirected_to event_path(assigns(:event))
    end

    test "should destroy event" do
      assert_difference('Event.count', -1) do
        delete :destroy, id: @event
      end

      assert_redirected_to events_path
    end
  end
end
