require 'httparty'
require 'nokogiri'

class EventsController < ApplicationController
  protect_from_forgery with: :exception

  def index
    today = Time.now.strftime('%Y-%m-%d')
    response = HTTParty.get('http://conventioncalendar.com/view/event-list/85?startDate=' + today)
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


