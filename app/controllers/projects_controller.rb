class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json

   def home
    @projects=current_user.projects
    @credits=current_user.projects.sum(:credits) 
  end
  
  def info
    @project=Project.find(params[:project_id])
    @tasks = Task.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def index
    @projects=Project.all
  end

  # GET /projects/new
  def new
    @user=User.find(params[:user_id])
    otp=@user.otp_code
    puts "-------db otp----#{otp}"
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
    @user=User.find(params[:user_id])
    @project=@user.projects.new(project_params)

    if params[:resend_otp]
      puts "---workings"
       otp=@user.otp_code
        puts "-------RESEND db otp----#{otp}"
        flash[:notice]="New OTP Sent"
        
    end
     otp_code=params[:otp]
    
     if @user.authenticate_otp(otp_code, drift: 120 ) == true
      @project.save
      flash[:notice]="Project Succesfully Created"
      redirect_to "/usershome"
    else
       render js: "alert('info')"
    end
    
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def updateproject
    @project=Project.find(params[:id])
    @project.update(project_params)
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to '/usershome', notice: 'Project was successfully updated.' }
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
      format.html { redirect_to "/usershome", notice: 'Project was successfully destroyed.' }
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
      params.require(:project).permit(:name, :code, :startdate, :enddate, :status, :credits, attachments_attributes: [:file])
    end
end
