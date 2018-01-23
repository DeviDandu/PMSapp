class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def home
    @project=Project.find(params[:project_id])
    puts "project id is #{@project.id}"
    @attachments=@project.attachments
    @tasks = @project.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def index
    @tasks=Task.all
  end

  # GET /tasks/new
  def new
    @project=Project.find(params[:project_id])
    puts "projwect id is #{@project.id}"
    @task = Task.new(params[:task])
  end

  # GET /tasks/1/edit
  def edit
   
    @task=Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def createtask
    @project=Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    @task.save
    respond_to do |format|
      if @task.save
        format.html { redirect_to "/projectdetails/#{@project.id}", notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def updatetask
    @project=Project.find(params[:project_id])
    @task=Task.find(params[:id])
    @task.update(task_params)
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to "/projectdetails/#{@project.id}", notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @project=Project.find(params[:project_id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to "/projectdetails/#{@project.id}", notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :description, :startdate, :enddate, :status, :project_id)
    end
end
