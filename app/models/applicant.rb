class Applicant < ApplicationRecord
  has_many :applicant_batch_ships
  has_many :batches, through: :applicant_batch_ships
  has_many :interviews, through: :applicant_batch_ships

  accepts_nested_attributes_for :applicant_batch_ships

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true }
end
