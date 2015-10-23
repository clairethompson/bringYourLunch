class Subscription < ActiveRecord::Base
  before_save { self.phone_number = self.phone_number.tr('^0-9', '')}

  VALID_PHONE_NUMBER_REGEX = /\A(\+0?1\s)?\(?\d{3}\)? ?-?[\s.-]?\d{3}[\s.|-]?\d{4}\z/
  validates :phone_number, presence: true,
                           format: {with: VALID_PHONE_NUMBER_REGEX },
                           uniqueness: true
  before_validation do
    self.phone_number = self.phone_number.tr('^0-9', '')
  end

end
