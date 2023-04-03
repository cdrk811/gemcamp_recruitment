class BatchesController < ApplicationController
  before_action :set_batch, only: %i[edit update destroy]

  def index
    @batches = Batch.all
  end

  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.new(params_batch)
    if @batch.save
      flash[:notice] = t('.notice')
      redirect_to batches_path
    else
      flash[:alert] = "#{t('.alert')}：#{@batch.errors.full_messages.join('，')}"
      render :new
    end
  end

  def edit; end

  def update
    if @batch.update(params_batch)
      flash[:notice] = t('.notice')
      redirect_to batches_path
    else
      flash[:alert] = "#{t('.alert')}：#{@batch.errors.full_messages.join('，')}"
      render :edit
    end
  end

  def destroy
    if @batch.destroy
      flash[:notice] = t('.notice')
    else
      flash[:alert] = "#{t('.alert')}：#{@batch.errors.full_messages.join('，')}"
    end
    redirect_to batches_path
  end

  private

  def set_batch
    @batch = Batch.find(params[:id])
  end

  def params_batch
    params.require(:batch).permit(:number, :status)
  end
end