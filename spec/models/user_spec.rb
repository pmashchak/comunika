require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  describe 'associations' do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to have_many(:messages).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:community) }
    context 'with phone' do
      subject { build :user, :with_phone }
      it { is_expected.to allow_value(subject.phone).for(:phone) }
    end
  end

  describe 'role' do
    context 'owner' do
      subject { build :user, :like_tenant }
      it { is_expected.to be_tenant }
    end

    context 'tenant' do
      subject { build :user, :like_owner }
      it { is_expected.to be_owner }
    end
  end
end
