class SendTextJob < ApplicationJob
  queue_as :send_text

  def perform(message_id)
    message = Message.find(message_id)
    return unless message.can_enque?
    text_service = TextService.new(message)
    text_service.send
  end
end
