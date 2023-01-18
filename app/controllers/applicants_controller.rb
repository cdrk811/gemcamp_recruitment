# frozen_string_literal: true

class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[edit update destroy]

  def index
    @applicants = Applicant.all
  end

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(params_applicant)
    if @applicant.save
      flash[:notice] = t('.notice')
      redirect_to applicants_path
    else
      flash[:alert] = "#{t('.alert')}：#{@applicant.errors.full_messages.join('，')}"
      render :new
    end
  end

  def edit; end

  def update
    if @applicant.update(params_applicant)
      flash[:notice] = t('.notice')
      redirect_to applicants_path
    else
      flash[:alert] = "#{t('.alert')}：#{@applicant.errors.full_messages.join('，')}"
      render :edit
    end
  end

  def destroy
    if @applicant.destroy
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@applicant.errors.full_messages.join(',')}"
    end
    redirect_to applicants_path
  end

  private

  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  def params_applicant
    params.require(:applicant).permit(:name, :phone, :interview_date, :status, :remarks, :email)
  end
end