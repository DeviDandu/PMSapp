class AttachmentsController < ApplicationController
  


  def new
    @project=Project.find(params[:project_id])
    @attachment= @project.attachments.new(params[:attachment])
  end

  def createattachment
     @project=Project.find(params[:project_id])
     @project= @project.attachments.new(attach_params)
   	 @project.save
      render "projects/home.html"
    end
  

  def destroy
    @attachment=Attachment.find(params[:id])
    @attachment.destroy
    render "projects/home.html"
  end

private
  def attach_params
      params.require(:attachment).permit(:file)
    end
end
