class CallLog < ApplicationRecord
  belongs_to :batch_applicant, optional: true
end