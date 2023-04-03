class Phase::PreClassSchedule < ApplicationRecord
  self.table_name = 'pre_class_schedules'
  include AASM

  belongs_to :applicant_batch_ship

  aasm column: :status do
    state :pending, initial: true
    state :confirmed, :declined

    event :confirm, before: :fill_reply_at do
      transitions from: :pending, to: :confirmed, if: :date_exists?
    end

    event :decline, before: :fill_reply_at do
      transitions from: :pending, to: :declined, if: :notes_exists?
    end
  end

  private

  def notes_exists?
    notes.present?
  end

  def date_exists?
    date.present?
  end

  def fill_reply_at
    self.reply_at = DateTime.current if reply_at.blank?
  end
end
