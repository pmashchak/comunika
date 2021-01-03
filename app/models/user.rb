class User < ApplicationRecord
  ROLES = %w{ tenant owner manager }

  belongs_to :community
  has_many   :messages

  validates :phone, phone: true, allow_blank: true

  before_save :normalize_phone

  def tenant?
    role == 'tenant'
  end

  def owner?
    role == 'owner'
  end

  private

  def normalize_phone
    self.phone = Phonelib.parse(phone).full_e164.presence
  end
end
