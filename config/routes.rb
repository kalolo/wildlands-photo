Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions'}, path_names: {
      sign_in: '/login', sign_out: 'logout', sign_up: 'register', edit: 'settings'
  }

  resources :images
  resources :albums

  root to: 'admin/dashboard#index'

  get '/projects/:name/images' => 'projects#images'
  get '/projects/:name/images/:imageid' => 'projects#image', as: 'project_image'
  get '/projects' => 'projects#show'

  get '/admin', to: 'admin/dashboard#index', as: 'admin'
  get '/admin/users', to: 'admin/users#index', as: 'admin_users'
  get '/admin/albums', to: 'admin/albums#index', as: 'admin_albums'

  #devise_scope :user do
  #  get 'sign_in', to: 'devise/sessions#new'
  #end
end
