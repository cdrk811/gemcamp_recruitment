class Applicants::BatchesController < ApplicationController
  before_action :set_applicant, only: :index

  def index
    @applicant_batches = BatchApplicant.where(applicant: @applicant)
  end

  private

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end
end