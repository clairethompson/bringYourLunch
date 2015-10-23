require 'rails_helper'

describe SubscriptionsController do
  before(:each) do

  end

  describe '#create' do
    it 'subscribes the number' do
      get(:create, {'phone_number' => '456-456-4567'})
      expect(Subscription.first.phone_number).to eq ('4564564567')
    end

    it 'says thanks'
  end


end
