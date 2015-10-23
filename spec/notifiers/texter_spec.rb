require 'rails_helper'
require 'twilio-ruby'
require_relative '../../app/notifiers/texter'

describe Texter do
  let(:texter) { Texter.new }
  describe '#send_text' do
    let(:fake_messages) { double(:messages, create: {}) }

    before do
      allow(Twilio::REST::Messages).to receive(:new).and_return(fake_messages)
    end

    it 'sends a text via twilio' do
      texter.send_text('fake_phone_number', 20000)
      expect(fake_messages).to have_received(:create).with(from: '+17148825731',
                                                          to: 'fake_phone_number',
                                                          body: 'Warning! Stay indoors! 20,000 people outside.',)
    end
  end

  describe '#format_number' do

    it 'adds commas to the number' do
      expect(texter.format_number(4564567)).to eq('4,564,567')
    end

  end
end
