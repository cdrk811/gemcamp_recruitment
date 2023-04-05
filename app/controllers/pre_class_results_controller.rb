# frozen_string_literal: true

class PreClassResultsController < ApplicationController
  before_action :set_batch
  before_action :set_pre_class_result, except: :index

  def index
    @pre_class_results = Phase::PreClassResult.includes(applicant_batch_ship: [:applicant, :batch])
    @pre_class_results = @pre_class_results.where(applicant_batch_ship: { batch: @batch }) if @batch
  end

  def edit; end

  def update
    if @pre_class_result.update(pre_class_result_params.slice(params[:column].to_sym))
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@pre_class_result.errors.full_messages.join('，')}"
    end

    redirect_to pre_class_results_path
  end

  def pass
    if @pre_class_result.may_pass? && @pre_class_result.pass!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to pre_class_results_path
  end

  def shortlist
    if @pre_class_result.may_shortlist? && @pre_class_result.shortlist!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to pre_class_results_path
  end

  def decline
    if @pre_class_result.may_decline? && @pre_class_result.decline!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to pre_class_results_path
  end

  def fail
    if @pre_class_result.may_fail? && @pre_class_result.fail!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to pre_class_results_path
  end

  private

  def pre_class_result_params
    params.require(:phase_pre_class_result).permit(:remarks, :proctor_note, :commute_duration, :date_attended)
  end

  def set_batch
    @batch = Batch.find(params[:batch_id]) if params[:batch_id]
  end

  def set_pre_class_result
    @pre_class_result = Phase::PreClassResult.find(params[:id])
  end
end