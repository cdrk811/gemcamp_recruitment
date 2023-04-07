class Phase::PreClassResult < ApplicationRecord
  self.table_name = 'pre_class_results'
  include AASM

  belongs_to :applicant_batch_ship

  aasm column: :result do
    state :pending, initial: true
    state :shortlisted, :passed, :declined, :failed

    event :pass do
      transitions from: :pending, to: :passed, success: :generate_gem_camp!, if: Proc.new { date_attended_exists? && remarks_exists? }
    end

    event :shortlist do
      transitions from: :pending, to: :shortlisted, if: :remarks_exists?
    end

    event :decline do
      transitions from: :pending, to: :declined, if: :remarks_exists?
    end

    event :fail, before: :clear_date_attended do
      transitions from: :pending, to: :failed, if: :remarks_exists?
    end
  end

  private

  def remarks_exists?
    remarks.present?
  end

  def date_attended_exists?
    date_attended.present?
  end

  def clear_date_attended
    self.date_attended = nil
  end

  def generate_gem_camp!
    applicant_batch_ship.build_gem_camp(pre_class_date: date_attended).save!
  end
end
