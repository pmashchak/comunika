require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { build :message }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:text) }
  it { is_expected.to validate_length_of(:text).is_at_least(2).is_at_most(160) }

  describe 'state' do
    it { is_expected.to be_draft }

    context 'enque' do
      it 'process the message' do
        expect(subject.enque).to be(true)
        is_expected.to be_queued
      end
    end

    context 'deliver' do
      subject { build :message, :queued }

      it 'delivers the message' do
        expect(subject.deliver).to be(true)
        is_expected.to be_delivered
      end
    end

    context 'error' do
      subject { build :message, :queued }

      it 'errors the message' do
        expect(subject.error).to be(true)
        is_expected.to be_error
      end
    end
  end
end
