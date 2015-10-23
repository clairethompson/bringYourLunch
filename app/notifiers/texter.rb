require 'twilio-ruby'

class Texter

  def send_text(phone_number, attendance)
    account_sid = 'AC078e00b1620113d93d580ed3a505b2fa'
    auth_token = '14ecdf5a226676da4a66baa57da50c8f'

    @client = Twilio::REST::Client.new(account_sid, auth_token)

    @client.account.messages.create({
                                        :from => '+17148825731',
                                        :to => phone_number,
                                        :body => "Warning! Stay indoors! #{format_number(attendance)} people outside.",
                                    })
  end

  def format_number(number)
    number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

end
