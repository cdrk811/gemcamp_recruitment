# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_batch_applicant, only: %i[edit update]

  def index
    @batch_applicants = BatchApplicant.includes(:applicant, :call_logs)
    @call_log = CallLog.new
  end

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(params_applicant)
    if @applicant.save
      add_batch_applicant
      flash[:notice] = t('.notice')
      redirect_to user_root_path
    else
      flash[:alert] = "#{t('.alert')}：#{@applicant.errors.full_messages.join('，')}"
      render :new
    end
  end

  def edit
    # render json: params
  end

  def update
    if @batch_applicant.update(params_batch_applicant)
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@batch_applicant.errors.full_messages.join('，')}"
    end
    redirect_to user_root_path
  end

  def add_call_log
    @call_log = CallLog.new(params_call_log)
    if @call_log.save
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@call_log.errors.full_messages.join('，')}"
    end
    redirect_to user_root_path
  end

  def update_call_log
    @call_log = CallLog.find(params[:id])
    if @call_log.update(params_call_log)
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@call_log.errors.full_messages.join('，')}"
    end
    redirect_to user_root_path
  end

  private

  def add_batch_applicant
    @batch_applicant = BatchApplicant.create(batch_id: params[:batch_id],
                                             applicant_id: @applicant.id)
  end

  def set_batch_applicant
    @batch_applicant = BatchApplicant.find(params[:id])
  end

  def params_applicant
    params.require(:applicant).permit(:name, :phone, :email)
  end

  def params_call_log
    params.require(:call_log).permit(:batch_applicant_id, :interview_date, :remarks)
  end

  def params_batch_applicant
    params.require(:batch_applicant).permit(:status, :remarks)
  end
end