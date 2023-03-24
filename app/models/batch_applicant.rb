class BatchApplicant < ApplicationRecord
  include AASM

  belongs_to :applicant
  belongs_to :batch
  has_many :call_logs

  scope :show_to_home, -> { pending.joins(:batch).where("batches.status = ?", :open) }

  aasm column: :status do
    state :pending, initial: true
    state :passed, :declined, :failed

    event :pass do
      transitions from: :pending, to: :passed
    end

    event :decline, before: :fill_interview_date do
      transitions from: :pending, to: :declined, if: :remarks_exists?
    end

    event :fail, before: :fill_interview_date do
      transitions from: :pending, to: :failed, if: :remarks_exists?
    end
  end

  private

  def remarks_exists?
    remarks.present?
  end

  def fill_interview_date
    self.interview_date = DateTime.current
  end
end
