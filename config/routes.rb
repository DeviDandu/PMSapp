Rails.application.routes.draw do


  devise_for :admins
# resources :sessions
#   get 'adminlogin' => 'sessions#new'
#   get 'adminlogut' => 'sessions#destroy'


  root'welcome#home'

  resources :organisations
  
 devise_for :users, controllers: { confirmations: 'users/confirmations' }
 

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'admins/sign_in' => 'admins#login'
	get 'usershome' => 'projects#home', as: :user_root

  get 'otpauth' => 'projects#otpauth'
	
  	
    get 'projects/new/:user_id' => 'projects#new'
    post 'createproject/:user_id' => 'projects#create'
    get 'editproject/:id' => 'projects#edit'
    patch 'updateproject/:id' => 'projects#updateproject'
    get 'deleteproject/:id' => 'projects#destroy'
    get 'projectslist' => 'projects#index'
  	resources :projects
    get 'projectdetails/:project_id' => 'tasks#home'

    resources :tasks
    get 'tasks/new/:project_id' => 'tasks#new'
    post 'createtask/:project_id' => 'tasks#createtask'
    get 'edittask/:project_id/:id' => 'tasks#edit'
    patch 'updatetask/:project_id/:id' => 'tasks#updatetask'
    get 'deletetask/:project_id/:id' => 'tasks#destroy'
    get 'taskslist' => 'tasks#index'

    get 'deletefile/:project_id/:id' => 'attachments#destroy'
    get 'attachment/new/:project_id' => 'attachments#new'
    post 'createattachment' => 'attachments#createattachment'
   
  	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
