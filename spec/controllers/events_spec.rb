require 'rails_helper'

describe EventsController do
  describe '#index' do
    let(:event_service) { double(get_events: nil) }
    it 'returns events from EventService' do
      allow(EventService).to receive(:new).and_return(event_service)
      get :index
      expect(event_service).to have_received(:get_events)
    end
  end
end

