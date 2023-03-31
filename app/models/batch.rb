class Batch < ApplicationRecord
  has_many :applicant_batch_ships
  has_many :applicants, through: :applicant_batch_ships

  enum status: { open: 0, close: 1 }

  def self.open_status
    open.last
  end
end
