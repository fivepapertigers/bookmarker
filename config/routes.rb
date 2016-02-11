Rails.application.routes.draw do
  
  

  resources :bookmarks

  resources :tags

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  get '/', to: 'pages#home'
end
