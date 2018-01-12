Rails.application.routes.draw do

  resources :organisations
  
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


	root'welcome#home'
	get 'usershome' => 'users#home'
	get 'projectinfo/:project_id' => 'projects#info'
  resources :tasks
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
