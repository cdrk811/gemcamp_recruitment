class Batch < ApplicationRecord

  has_many :batch_applicant
  has_many :applicant, through: :batch_applicant

  enum status: { open: 0, close: 1 }

  def self.batch_status
    where(status: 0).pluck(:id)
  end
end
