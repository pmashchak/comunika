require 'rails_helper'

describe TextService do
  subject { described_class.new(message) }

  let(:message) { create(:message) }

  it 'enques message' do
    expect { subject }.to change(message, :state).from('draft').to('queued')
  end

  describe '#send' do
    let(:message) { create(:message, :queued) }
    let(:client) { double(:client) }
    let(:messages) { double(:messages) }
    let(:response) { double(:response, sid: SecureRandom.hex) }
    let(:message_text) { message.text }

    before do
      expect(TwilioClient).to receive(:client) { client }
      expect(client).to receive(:messages) { messages }
    end

    shared_examples_for :deliver_message do
      it 'delivers the message' do
        expect(messages).to receive(:create).with(hash_including(from: Comunika.config.twilio_phone_number, to: message.user.phone, body: message_text)) { response }
        expect { subject.send }.to change(message, :state).from('queued').to('delivered')
        expect(message.sid).to eq(response.sid)
      end
    end

    it_behaves_like :deliver_message

    it 'fails to deliver the message' do
      expect(messages).to receive(:create).and_raise(Twilio::REST::TwilioError)
      expect { subject.send }.to change(message, :state).from('queued').to('error')
    end

    context 'owner user' do
      let(:message) { create(:message, :queued, user: create(:user, :like_owner)) }
      let(:message_text) { "To owner: #{message.text}" }

      it_behaves_like :deliver_message
    end

    context 'tenant user' do
      let(:message) { create(:message, :queued, user: create(:user, :like_tenant)) }
      let(:message_text) { "To tenant: #{message.text}" }

      it_behaves_like :deliver_message
    end
  end
end
