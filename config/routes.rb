Rails.application.routes.draw do

  get 'attachments/destroy'

  resources :organisations
  
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


	root'welcome#home'
	get 'usershome' => 'projects#home'
	
  	
    get 'projects/new/:user_id' => 'projects#new'
    post 'createproject/:user_id' => 'projects#create'
    get 'editproject/:id' => 'projects#edit'
    patch 'updateproject/:id' => 'projects#updateproject'
  	resources :projects
    get 'projectdetails/:project_id' => 'tasks#home'

     resources :tasks
    get 'tasks/new/:project_id' => 'tasks#new'
     post 'createtask/:project_id' => 'tasks#createtask'
     get 'edittask/:id' => 'tasks#edit'
      patch 'updatetask/:id' => 'tasks#updatetask'
    get 'deletetask/:id' => 'tasks#destroy'

    get 'deletefile/:id' => 'attachments#destroy'
    get 'attachment/new/:project_id' => 'attachments#new'
   post 'createattachment' => 'attachments#createattachment'
   
  	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
