
RailsAdmin.config do |config|
require Rails.root.join('lib', 'rails_admin', 'custom_actions.rb')

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
  warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
   
    collection do
      visible do
        bindings[:abstract_model].model.to_s == "Project"
      end
    end
  
  end
end
