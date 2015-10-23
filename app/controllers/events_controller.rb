require 'httparty'
require 'nokogiri'

class EventsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    EventService.new.get_events
    render json: @convention_list

  end
end


