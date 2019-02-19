class Community < ApplicationRecord
  validates :subdomain, uniqueness: { case_sensitive: false }
end
