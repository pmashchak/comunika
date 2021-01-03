require 'rails_helper'

describe Community, type: :model do
  subject { build :community }

  it { is_expected.to have_many(:users) }
  it { should validate_uniqueness_of(:subdomain).case_insensitive }
end
