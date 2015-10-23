
class NotificationJob
  def initialize(options = {})
    @event_service = options[:event_service] || EventService.new
    @texter = options[:texter] || Texter.new
  end

  def send_texts
    events = @event_service.get_tomorrows_events
    total_people = events.map { |e| e[:attendance] }.reduce(:+)
    Subscription.all.each do |s|
      if total_people > 10000
        @texter.send_text(s.phone_number, total_people)
      end
    end
  end

  def send_example_text
    Subscription.all.each do |s|
      @texter.send_text(s.phone_number, 'Hello, welcome to Bring Your Lunch!')
    end
  end
end
