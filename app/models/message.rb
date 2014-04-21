class Message < ActiveRecord::Base
  before_create :send_sms

private

  def send_sms
    response = RestClient::Request.new(
    :method => :post,
    :url => 'https://api.twilio.com/2010-04-01/Accounts/AC379f52903f49a7c7eba0f3cdee2e72d8/Messages.json',
    :user => ENV['TWILIO_ACCOUNT_SID'],
    :password => ENV['TWILIO_AUTH_TOKEN'],
    :payload => { :Body => body,
                  :From => from,
                  :To => to }
    ).execute
    rescue RestClient::BadRequest => error
      message = JSON.parse(error.response)['message']
      errors.add(:base, message)
      false

  end
end

