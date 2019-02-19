class User < ApplicationRecord
  belongs_to :community

  ROLES = %w{ tenant owner manager }
end
