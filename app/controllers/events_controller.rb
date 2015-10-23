class EventsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @events = EventService.new.get_events
  end
end


