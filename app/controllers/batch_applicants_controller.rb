# frozen_string_literal: true

class BatchApplicantsController < ApplicationController
  before_action :set_batch_applicant, except: %i[index new create]
  before_action :set_batch, only: %i[index new create]
  before_action :clear_sourcing_channel, only: %i[create update]

  def index
    @batch_applicants = ApplicantBatchShip.includes(:applicant, :batch, interview: :call_logs)
    params[:status] = ['pending'] if params[:status].blank?
    @batch_applicants = @batch_applicants.current_opened_batch
                                         .filter_by_interview_status(params[:status])
    @call_log = CallLog.new
  end

  def new
    @applicant = ApplicantBatchShip.new
    @applicant.build_applicant
  end

  def create
    @batch_applicant = ApplicantBatchShip.new(applicant_create_params)
    if @batch_applicant.save
      flash[:notice] = t('.notice')
      redirect_to user_root_path
    else
      flash[:alert] = "#{t('.alert')}：#{@batch_applicant.errors.full_messages.join('，')}"
      render :new
    end
  end

  def edit; end

  def update
    if @batch_applicant.update(applicant_update_params)
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

  def set_batch
    @batch = Batch.open_status
  end

  def set_batch_applicant
    @batch_applicant = ApplicantBatchShip.find(params[:id])
  end

  def applicant_create_params
    params.require(:applicant_batch_ship).permit(:application_date, :resume_link, :batch_id, sourcing_channel: [],
                                                 applicant_attributes: [:id, :name, :phone, :email])
  end

  def applicant_update_params
    params.require(:applicant_batch_ship).permit(:application_date, sourcing_channel: [],
                                                 interview_attributes: [:id, :remarks, :interview_date])
  end

  def clear_sourcing_channel
    params[:applicant_batch_ship][:sourcing_channel]&.reject!(&:empty?)
  end
end