Rails.application.routes.draw do
  root 'application#index'
  resources :notes
  resources :tasks
  resources :announcements
  resources :invitations

  resources :groups do
    resources :invitations
    resources :tasks
    resources :announcements
  end

  resources :users
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/auth/facebook/callback', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
