# frozen_string_literal: true

class PreClassSchedulesController < ApplicationController
  before_action :set_batch
  before_action :set_pre_class_schedule, only: %i[edit update confirm decline]

  def index
    @pre_class_schedules = Phase::PreClassSchedule.includes(applicant_batch_ship: [:applicant, :batch])
    @pre_class_schedules = @pre_class_schedules.where(applicant_batch_ship: { batch: @batch }) if @batch
  end

  def edit; end

  def update
    if @pre_class_schedule.update(pre_class_schedule_params.slice(params[:column].to_sym))
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@pre_class_schedule.errors.full_messages.join('，')}"
    end

    redirect_to pre_class_schedules_path
  end

  def confirm
    if @pre_class_schedule.may_confirm? && @pre_class_schedule.confirm!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to pre_class_schedules_path
  end

  def decline
    if @pre_class_schedule.may_decline? && @pre_class_schedule.decline!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to pre_class_schedules_path
  end

  private

  def pre_class_schedule_params
    params.require(:phase_pre_class_schedule).permit(:notes, :reply_at, :sent_at, :date)
  end

  def set_batch
    @batch = Batch.find(params[:batch_id]) if params[:batch_id]
  end

  def set_pre_class_schedule
    @pre_class_schedule = Phase::PreClassSchedule.find(params[:id])
  end
end