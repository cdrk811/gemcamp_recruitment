class Batch < ApplicationRecord
  has_many :applicant_batch_ships
  has_many :batches, through: :applicant_batch_ships

  enum status: { open: 0, close: 1 }

  def self.batch_status
    open.pluck(:id)
  end
end
