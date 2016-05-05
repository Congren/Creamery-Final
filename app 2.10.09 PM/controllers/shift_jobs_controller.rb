class ShiftJobsController < ApplicationController
  load_and_authorize_resource

  before_action :set_shift_job, only: [:show, :edit, :update, :destroy]
  
  def index
    @shift_jobs = ShiftJob.all.paginate(page: params[:page]).per_page(10)  
  end

  def show
  end

  def new
    @shift_job = ShiftJob.new
  end

  def edit
  end

  def create
    @shift_job = ShiftJob.new(shift_job_params)
    
    if @shift_job.save
      redirect_to shift_job_path(@shift_job), notice: "Successfully created #{@shift_job}."
    else
      render action: 'new'
    end
  end

  def update
    if @shift_job.update(shift_job_params)
      redirect_to shift_job_path(@shift_job), notice: "Successfully updated #{@shift_job}."
    else
      render action: 'edit'
    end
  end

  def destroy
    @shift_job.destroy
    redirect_to shift_jobs_path, notice: "Successfully removed #{@shift_job} from the AMC system."
  end

  private
  def set_shift_job
    @shift_job = ShiftJob.find(params[:id])
  end

  def shift_job_params
    params.require(:shift_job).permit(:job_id, :shift_id)
  end

end