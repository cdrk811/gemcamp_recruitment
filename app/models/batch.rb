class Batch < ApplicationRecord

  has_many :batch_applicant
  has_many :applicant, through: :batch_applicant

  enum status: { open: 0, close: 1 }

  def self.batch_status
    open.pluck(:id)
  end
end
