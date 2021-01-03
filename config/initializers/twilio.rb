require 'twilio_client'

TwilioClient.setup do |config|
  config.account_sid = Comunika.config.twilio_account_sid
  config.auth_token = Comunika.config.twilio_auth_token
  config.phone_number = Comunika.config.twilio_phone_number
end
