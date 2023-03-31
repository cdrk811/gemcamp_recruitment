class ApplicantBatchShip < ApplicationRecord
  belongs_to :applicant
  belongs_to :batch
  has_one :interviews, class_name: 'Phase::Interview'

end
