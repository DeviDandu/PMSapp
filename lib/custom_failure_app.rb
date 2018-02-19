class CustomFailureApp < Devise::FailureApp
  def redirect_url
    scope_url  # Always redirect to signin page
  end
end