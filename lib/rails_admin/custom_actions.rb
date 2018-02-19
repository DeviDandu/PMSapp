module RailsAdmin
  module Config
    module Actions
      # common config for custom actions
      
     
      class Collection < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true	#	this is for all records in specific model
        end
        register_instance_option :controller do
          Proc.new do
            # call model.method here
            @projects=Project.where(status: "Active")      
          end
        end
      end
      
    end
  end
end