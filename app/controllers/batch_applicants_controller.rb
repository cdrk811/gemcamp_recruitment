# frozen_string_literal: true

class BatchApplicantsController < ApplicationController
  before_action :set_batch_applicant, except: %i[index new create]

  def index
    @batch_applicants = ApplicantBatchShip.includes(:applicant, :batch, interview: :call_logs).show_to_home
    @call_log = CallLog.new
  end

  def new
    @applicant = Applicant.new
    @batch = Batch.open_status
    @applicant.applicant_batch_ships.build
  end

  def create
    @applicant = Applicant.new(params_applicant)
    @batch = Batch.open_status
    if @applicant.save
      flash[:notice] = t('.notice')
      redirect_to user_root_path
    else
      flash[:alert] = "#{t('.alert')}：#{@applicant.errors.full_messages.join('，')}"
      render :new
    end
  end

  def edit; end

  def update
    if @batch_applicant.update(params_batch_applicant)
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@batch_applicant.errors.full_messages.join('，')}"
    end
    redirect_to user_root_path
  end

  def pass
    interview = @batch_applicant.interview
    if interview.may_pass? && interview.pass!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to user_root_path
  end

  def decline
    interview = @batch_applicant.interview
    if interview.may_decline? && interview.decline!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to user_root_path
  end

  def fail
    interview = @batch_applicant.interview
    if interview.may_fail? && interview.fail!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to user_root_path
  end

  private

  def set_batch_applicant
    @batch_applicant = ApplicantBatchShip.find(params[:id])
  end

  def params_applicant
    params.require(:applicant).permit(:name, :phone, :email,
                                      applicant_batch_ships_attributes: [:id, :application_date, :sourcing_channel,
                                                              :resume_link, :batch_id])
  end

  def params_batch_applicant
    params.require(:applicant_batch_ship).permit(interview_attributes: [:id, :remarks])
  end
end