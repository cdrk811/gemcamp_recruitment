# frozen_string_literal: true

class GemCampsController < ApplicationController
  before_action :set_batch
  before_action :set_gem_camp, except: :index

  def index
    @gem_camps = Phase::GemCamp.includes(applicant_batch_ship: [:applicant, :batch])
    @gem_camps = @gem_camps.where(applicant_batch_ship: { batch: @batch }) if @batch
  end

  def edit; end

  def update
    if @gem_camp.update(gem_camp_params.slice(params[:column].to_sym))
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@gem_camp.errors.full_messages.join('，')}"
    end

    redirect_to gem_camps_path
  end

  def confirm
    if @gem_camp.may_confirm? && @gem_camp.confirm!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to gem_camps_path
  end

  def decline
    if @gem_camp.may_decline? && @gem_camp.decline!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to gem_camps_path
  end

  def deliver
    if @gem_camp.may_deliver? && @gem_camp.deliver!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to gem_camps_path
  end

  def fail
    if @gem_camp.may_fail? && @gem_camp.fail!
      flash[:notice] = t('.notice')
    else
      flash[:error] = t('.error')
    end

    redirect_to gem_camps_path
  end

  private

  def gem_camp_params
    params.require(:phase_gem_camp).permit(:pre_class_date, :letter_type, :signed_via,
                                           :sent_at, :reply_at, :status,:notes)
  end

  def set_batch
    @batch = Batch.find(params[:batch_id]) if params[:batch_id]
  end

  def set_gem_camp
    @gem_camp = Phase::GemCamp.find(params[:id])
  end
end