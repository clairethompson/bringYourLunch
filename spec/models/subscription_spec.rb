require 'rails_helper'

RSpec.describe Subscription, type: :model do
  before :each do
    @user = Subscription.new(phone_number: '4564564567')
  end

  it 'should be valid' do
    expect(@user).to be_valid
  end

  it 'should have a phone number' do
    @user.phone_number = ''
    expect(@user).not_to be_valid
  end

  describe 'the phone number' do
    it 'should be only digits' do
      @user.phone_number = 'i am not a number'
      expect(@user).not_to be_valid
      @user.phone_number = '1234 blah'
      expect(@user).not_to be_valid
      @user.phone_number = 'blh 1234'
      expect(@user).not_to be_valid
    end

    it 'should accept different number formats' do
      @user.phone_number = '456-456-4567'
      expect(@user).to be_valid
      @user.phone_number = '(456)456-4567'
      expect(@user).to be_valid
      @user.phone_number = '(456) 456-4567'
      expect(@user).to be_valid
    end

    it 'should be unique from other numbers' do
      same_number_user = Subscription.new(phone_number: '456-456-4567')
      @user.save
      expect(same_number_user).not_to be_valid
    end
  end
end
