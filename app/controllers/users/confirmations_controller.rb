class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super do |resource|  
      ip=request.remote_ip
      puts "-----------#{ip}"
      User.update(current_sign_in_ip: ip)
    end
  end
end