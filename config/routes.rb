Rails.application.routes.draw do
  resources :images
  resources :albums
  root 'welcome#index'

  get '/projects/:name/images' => 'projects#images'
  get '/projects' => 'projects#show'
end
