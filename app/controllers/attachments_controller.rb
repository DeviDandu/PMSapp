class AttachmentsController < ApplicationController
  


  def new
    @project=Project.find(params[:project_id])
    @attachment= @project.attachments.new(params[:attachment])
  end

  def createattachment
     @project=Project.find(params[:project_id])
     @project= @project.attachments.new(attach_params)
   	 @project.save
      redirect_to "/projectdetails/#{params[:project_id]}"
    end
  

  def destroy
    @project=Project.find(params[:project_id])
    @attachment=Attachment.find(params[:id])
    @attachment.destroy
    redirect_to "/projectdetails/#{@project.id}"
  end

private
  def attach_params
      params.require(:attachment).permit(:file)
    end
end
