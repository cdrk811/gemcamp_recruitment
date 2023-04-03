class ApplicantBatchShip < ApplicationRecord
  belongs_to :applicant
  belongs_to :batch
  has_one :interview, class_name: 'Phase::Interview'
  has_one :pre_class_schedule, class_name: 'Phase::PreClassSchedule'

  accepts_nested_attributes_for :interview

  scope :show_to_home, -> { joins(:batch).where('batches.id = ?', Batch.open_status.id)
                                         .joins(:interview).where('interviews.status = ?', :pending) }

  before_create :set_application_date, if: Proc.new { application_date.blank? }
  after_create :generate_phase_interview!

  private

  def set_application_date
    self.application_date = DateTime.current
  end

  def generate_phase_interview!
    build_interview.save!
  end
end
