require 'rails_helper'

describe Community, type: :model do
  it { should validate_uniqueness_of(:subdomain).case_insensitive }
end