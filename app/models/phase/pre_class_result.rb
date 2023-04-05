class Phase::PreClassResult < ApplicationRecord
  self.table_name = 'pre_class_results'
  include AASM

  belongs_to :applicant_batch_ship

  aasm column: :result do
    state :pending, initial: true
    state :shortlisted, :passed, :declined, :failed

    event :pass do
      transitions from: :pending, to: :passed
    end

    event :shortlist do
      transitions from: :pending, to: :shortlisted
    end

    event :decline do
      transitions from: :pending, to: :declined, if: :remarks_exists?
    end

    event :fail do
      transitions from: :pending, to: :failed, if: :remarks_exists?
    end
  end

  private

  def remarks_exists?
    remarks.present?
  end
end
