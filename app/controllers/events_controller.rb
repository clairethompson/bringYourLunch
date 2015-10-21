require 'httparty'
require 'nokogiri'

class EventsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    response = HTTParty.get('http://conventioncalendar.com/view/event-list/85?startDate=2015-10-21')
    doc = Nokogiri::HTML(response)

    @convention_list = doc.css('.cc-list').map do |convention|
      {
          date: convention.css('.cc-list-day strong').text.delete!("\n").squeeze(' '),
          :attendance => convention.css('.cc-list-event').text.tr('^0-9', '')
      }
    end

    render json: @convention_list

  end
end


