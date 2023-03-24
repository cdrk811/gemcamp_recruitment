class CallLog < ApplicationRecord
  belongs_to :batch_applicant, optional: true

  default_scope { order(:interview_date) }

  def self.recent_logs
    last(3).map do |log|
      "#{log.interview_date.strftime('%B %d, %Y')} : #{log.remarks}"
    end
  end
end