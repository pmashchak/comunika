class Message < ApplicationRecord
  belongs_to :user

  validates :text, presence: true, length: { minimum: 2, maximum: 160 }

  def self.all_states
    state_machines[:state].states.map(&:name)
  end

  state_machine :state, initial: :draft do
    state :draft, :queued, :delivered, :error

    event :enque do
      transition draft: :queued
    end

    event :deliver do
      transition queued: :delivered
    end

    event :error do
      transition queued: :error
    end
  end
end
