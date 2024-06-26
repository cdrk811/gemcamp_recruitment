class ApplicantBatchShip < ApplicationRecord
  SOURCING_CHANNEL_LIST = %w[
    facebook rails_website indeed
  ].freeze

  serialize :sourcing_channel, Array

  belongs_to :applicant
  belongs_to :batch
  has_one :interview, class_name: 'Phase::Interview'
  has_one :pre_class_schedule, class_name: 'Phase::PreClassSchedule'
  has_one :pre_class_result, class_name: 'Phase::PreClassResult'
  has_one :gem_camp, class_name: 'Phase::GemCamp'

  accepts_nested_attributes_for :interview
  accepts_nested_attributes_for :applicant

  scope :current_opened_batch, -> { joins(:batch).where('batches.id = ?', Batch.open_status&.id) }
  scope :filter_by_interview_status, ->(status) { joins(:interview).where('interviews.status IN (?)', status) }

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
