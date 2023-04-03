class CallLog < ApplicationRecord
  belongs_to :interview, optional: true

  default_scope { order(:interview_date) }

  def self.recent_logs
    last(3).map do |log|
      log.date_and_remarks
    end
  end

  def date_and_remarks
    "#{interview_date&.strftime('%B %d, %Y')} : #{remarks}"
  end
end