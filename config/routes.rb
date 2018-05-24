Rails.application.routes.draw do
  resources :images
  resources :albums
  root 'welcome#index'

  get '/projects/:name/images' => 'projects#images'
  get '/projects/:name/images/:imageid' => 'projects#image', as: 'project_image'
  get '/projects' => 'projects#show'
end
