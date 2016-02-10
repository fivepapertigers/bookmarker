Rails.application.routes.draw do
  
  

  resource :tags

  get '/auth/:provider/callback', to: 'sessions#create'
end
