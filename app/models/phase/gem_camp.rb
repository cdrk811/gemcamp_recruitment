class Phase::GemCamp < ApplicationRecord
  self.table_name = 'gem_camps'
  include AASM

  belongs_to :applicant_batch_ship

  enum letter_type: { confirmation: 0, thank_you: 1 }
  enum signed_via: { email: 0, onsite: 1 }

  aasm column: :status do
    state :pending, initial: true
    state :confirmed, :declined, :delivered

    event :confirm, before: :fill_reply_at do
      transitions from: :pending, to: :confirmed
    end

    event :decline, before: :fill_reply_at do
      transitions from: :pending, to: :declined, if: :notes_exists?
    end

    event :deliver, before: :fill_sent_at do
      transitions from: :pending, to: :delivered
    end
  end

  private

  def notes_exists?
    notes.present?
  end

  def fill_reply_at
    self.reply_at = DateTime.current if reply_at.blank?
  end

  def fill_sent_at
    self.sent_at = DateTime.current if sent_at.blank?
  end
end
