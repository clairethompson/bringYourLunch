class EventService
  def get_events
    today = Time.now.strftime('%Y-%m-%d')
    response = HTTParty.get('http://conventioncalendar.com/view/event-list/85?startDate=' + today)
    doc = Nokogiri::HTML(response)

    doc.css('.cc-list').map do |convention|
      date_range = convention.css('.cc-list-day strong').text.delete!("\n").squeeze(' ')

      date_parts = date_range.match /([^-]*)-([^,]*),(.*)/
      start_date = Date.parse(date_parts[1] + ' ' + date_parts[3])
      end_date = Date.parse(date_parts[2] + ' ' + date_parts[3])

      event_text = convention.css('.cc-list-event').text.delete!("\n").squeeze(' ')
      attendance = event_text.match(/.* - ([\d]*) est\. attendees/)[1].to_i

      {
          start_date: start_date,
          end_date: end_date,
          attendance: attendance
      }
    end
  end

  def get_tomorrows_events
    events = get_events
    events.select do |e|
      e[:start_date] <= Date.tomorrow and Date.tomorrow <= e[:end_date]
    end
  end
end
