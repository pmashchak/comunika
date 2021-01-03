module TwilioClient
  class << self
    attr_accessor :configuration, :client, :sid
  end

  class Configuration
    attr_accessor :account_sid, :auth_token, :phone_number
  end

  def self.setup
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.client
    @client ||= Twilio::REST::Client.new(configuration.account_sid, configuration.auth_token)
  end
end
