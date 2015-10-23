require_relative '../../app/models/subscription'

describe NotificationJob do
  let(:event_service) { double(:event_service, get_tomorrows_events: tomorrows_events) }
  let(:notification_job) { NotificationJob.new(event_service: event_service, texter: fake_texter) }
  let(:fake_texter) { double(send_text: nil) }
  describe '#send_texts' do
    let!(:subscription1) { Subscription.create(phone_number: '5555555555') }
    let!(:subscription2) { Subscription.create(phone_number: '4444444444') }

    describe 'when there is a small event' do
      let(:tomorrows_events) { [{attendance: 5}] }
      it 'does not send texts to everyone' do
        expect(fake_texter).to_not receive(:send_text)
        notification_job.send_texts
      end
    end
    describe 'when there is a large event' do
      let(:tomorrows_events) { [{attendance: 20000}] }
      it 'sends a text to everyone' do
        expect(fake_texter).to receive(:send_text).with(subscription1.phone_number, 20000)
        expect(fake_texter).to receive(:send_text).with(subscription2.phone_number, 20000)
        notification_job.send_texts
      end
    end
    describe 'when there are 2 medium size events' do
      let(:tomorrows_events) { [{attendance: 6000}, {attendance: 5000}] }
      it 'sends a text to everyone' do
        expect(fake_texter).to receive(:send_text).with(subscription1.phone_number, 11000)
        expect(fake_texter).to receive(:send_text).with(subscription2.phone_number, 11000)
        notification_job.send_texts
      end
    end

  end
end
