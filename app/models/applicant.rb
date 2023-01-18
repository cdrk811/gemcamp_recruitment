class Applicant < ApplicationRecord
  include AASM

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true }

  aasm column: :status do
    state :pending, initial: true
    state :passed, :declined, :failed

    event :pass do
      transitions from: :pending, to: :passed
    end

    event :decline do
      transitions from: :pending, to: :declined
    end

    event :fail do
      transitions from: :pending, to: :failed
    end
  end
end
