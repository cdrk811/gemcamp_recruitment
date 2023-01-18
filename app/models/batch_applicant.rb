class BatchApplicant < ApplicationRecord
  include AASM

  belongs_to :applicant
  belongs_to :batch
  has_many :call_logs

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
