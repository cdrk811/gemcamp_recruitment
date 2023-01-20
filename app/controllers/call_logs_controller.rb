class CallLogsController < ApplicationController
  before_action :set_call_log, only: :update

  def create
    @call_log = CallLog.new(params_call_log)
    @call_log.batch_applicant_id = params[:batch_applicant_id]
    if @call_log.save
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@call_log.errors.full_messages.join('，')}"
    end
    redirect_to user_root_path
  end

  def update
    if @call_log.update(params_call_log)
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@call_log.errors.full_messages.join('，')}"
    end
    redirect_to user_root_path
  end

  private

  def set_call_log
    @call_log = CallLog.find(params[:id])
  end

  def params_call_log
    params.require(:call_log).permit(:batch_applicant_id, :interview_date, :remarks)
  end
end