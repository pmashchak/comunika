class Community < ApplicationRecord
  has_many :users
  validates :subdomain, uniqueness: { case_sensitive: false }
end
