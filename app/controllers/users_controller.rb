class UsersController < ApplicationController
 
  def home
  	@projects=Project.all
  end
  
end
