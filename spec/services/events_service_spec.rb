require 'rails_helper'

describe EventService do
  let(:event_service) { EventService.new }
  describe '#get_events' do
    let(:event_list_url) { 'http://conventioncalendar.com/view/event-list/85?startDate=2014-08-17' }
    let(:event_list_html) { File.read('spec/fixtures/eventList.html') }
    let(:test_time) { Date.parse('Aug 18 2014') }

    before :each do

      stub_request(:get, event_list_url).to_return(status: 200, body: event_list_html)
    end

    it 'contains the start date' do
      Timecop.freeze(test_time) do
        response = EventService.new.get_events
        expect(response[0][:start_date]).to eq(Date.parse('Oct 04 2015'))
      end
    end

    it 'contains the end date' do
      Timecop.freeze(test_time) do
        response = EventService.new.get_events
        expect(response[0][:end_date]).to eq(Date.parse('Oct 06 2015'))
      end
    end

    it 'contains the number of attendees' do
      Timecop.freeze(test_time) do
        response = EventService.new.get_events
        expect(response[0][:attendance]).to eq(8000)
      end
    end
  end

  describe '#get_tomorrows_events' do
    let(:event_list) { [{
                            start_date: Date.parse('Jan 05 2012'),
                            end_date: Date.parse('Jan 17 2012')
                        },
                        {
                            start_date: Date.parse('Oct 05 2015'),
                            end_date: Date.parse('Oct 17 2015')
                        },
                        {
                            start_date: Date.parse('Dec 05 2017'),
                            end_date: Date.parse('Dec 17 2017')
                        },
                        {
                            start_date: Date.parse('Dec 07 2017'),
                            end_date: Date.parse('Dec 10 2017')
                        }
    ] }
    before do
      allow(event_service).to receive(:get_events).and_return(event_list)
    end
    describe 'when there is an event that starts tomorrow' do
      it 'returns the event' do
        Timecop.freeze(Date.parse('Oct 04 2015')) do
          expect(event_service.get_tomorrows_events.length).to eq(1)
        end
      end
    end

    describe 'when there is an event that spans tomorrow' do
      it 'returns the event' do
        Timecop.freeze(Date.parse('Oct 10 2015')) do
          expect(event_service.get_tomorrows_events.length).to eq(1)
        end
      end
    end
    describe 'when there is an even that ends tomorrow' do
      it 'returns the event' do
        Timecop.freeze(Date.parse('Oct 16 2015')) do
          expect(event_service.get_tomorrows_events.length).to eq(1)
        end
      end
    end
    describe 'when there is more than one event tomorrow' do
      it 'returns both events' do
        Timecop.freeze(Date.parse('Dec 08 2017')) do
          expect(event_service.get_tomorrows_events.length).to eq(2)
        end
      end
    end
    describe 'when there is no event tomorrow' do
      it 'returns an empty array' do
        Timecop.freeze(Date.parse('Nov 10 2015')) do
          expect(event_service.get_tomorrows_events.length).to eq(0)
        end
      end
    end
  end
end
