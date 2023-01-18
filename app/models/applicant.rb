class Applicant < ApplicationRecord

  has_many :batch_applicant
  has_many :batch, through: :batch_applicant

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true }
end
