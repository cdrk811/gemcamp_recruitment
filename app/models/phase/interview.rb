class Phase::Interview < ApplicationRecord
  self.table_name = 'interviews'
  include AASM

  has_many :call_logs
  belongs_to :applicant_batch_ship

  aasm column: :status do
    state :pending, initial: true
    state :passed, :declined, :failed

    event :pass, before: :fill_interview_date do
      transitions from: :pending, to: :passed, success: :generate_pre_class_schedule!
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
    self.interview_date = DateTime.current if interview_date.blank?
  end

  def generate_pre_class_schedule!
    applicant_batch_ship.build_pre_class_schedule.save!
  end
end
