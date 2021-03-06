class Devise::DisplayqrController < DeviseController
  prepend_before_action :authenticate_scope!, :only => [:show,:update,:refresh]

  include Devise::Controllers::Helpers

  # GET /resource/displayqr
  def show
    if resource.nil? || resource.gauth_secret.nil?
      sign_in scope, resource, :bypass => true
      redirect_to stored_location_for(scope) || :root
    else
      @tmpid = resource.assign_tmp
      puts @tmpid
      render :show
    end
  end

  def update

    if resource.gauth_tmp != params[resource_name]['tmpid'] || !resource.validate_token(params[resource_name]['gauth_token'].to_i)
      set_flash_message(:error, :invalid_token)
      render :show
      return
    end

    if resource.set_gauth_enabled(resource_params)
      set_flash_message :notice, (resource.gauth_enabled? ? :enabled : :disabled)
      if resource.gauth_enabled.to_i != 0
      flash[:alert]="Your backup Code is.....##{resource.backup_code}"
      end
     # sign_in scope, resource, :bypass => true
      if resource_name.to_s == "admin"
        redirect_to "/admin"
      else
         redirect_to stored_location_for(scope) || :root
       end

    else
      render :show
    end
  end

  def refresh
    unless resource.nil?
      resource.send(:assign_auth_secret)
      resource.save
      set_flash_message :notice, :newtoken
      sign_in scope, resource, :bypass => true
      redirect_to [resource_name, :displayqr]
    else
      redirect_to :root
    end
  end

  private
  def scope
    resource_name.to_sym
  end

  def authenticate_scope!
    send(:"authenticate_#{resource_name}!")
    self.resource = send("current_#{resource_name}")
  end

  def resource_params
    return params.require(resource_name.to_sym).permit(:gauth_enabled) if strong_parameters_enabled?
    params
  end

  def strong_parameters_enabled?
    defined?(ActionController::StrongParameters)
  end
end