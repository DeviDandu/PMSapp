class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json

   def home
    @projects=current_user.projects
  end
  
  def info
    @project=Project.find(params[:project_id])
    puts 'id is in #{params[:project_id]}'
    @tasks = Task.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @user=User.find(params[:user_id])
    puts "id is #{@user.id}"
    @project=@user.projects.new(params[:project])
    3.times { @project.attachments.build }
  end

  # GET /projects/1/edit
  def edit
    @project=Project.find(params[:id])
    3.times { @project.attachments.build }
  end

  # POST /projects
  # POST /projects.json
  def create
    puts "id is params[:user_id]"
    @user=User.find(params[:user_id])

    @project=@user.projects.new(project_params)
    @project.save
   

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def updateproject
    @project=Project.find(params[:id])
    @project.update(project_params)
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project=Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :code, :startdate, :enddate, :status, attachments_attributes: [:file])
    end
end
