class TextService
  attr_accessor :message, :response

  def initialize(message)
    @message = message
  end

  def send
    begin
      response = TwilioClient.client.messages.create(
        from: Comunika.config.twilio_phone_number,
        to: message.user.phone,
        body: get_body)
      message.sid = response.sid
      message.enque
    rescue Twilio::REST::TwilioError => e
      e.message
    end
  end

  private

  def get_body
    if message.user.tenant?
      "To tenant: #{message.text}"
    elsif message.user.owner?
      "To owner: #{message.text}"
    else
      message.text
    end
  end
end
