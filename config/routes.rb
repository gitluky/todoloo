Rails.application.routes.draw do
  root 'application#index'
  resources :notes



  resources :users do
    resources :invitations
  end

  resources :groups do
    resources :invitations
    resources :tasks
    resources :announcements
    post '/users/:id/create_admin', to: 'users#create_admin', as: 'create_admin'
    post '/users/:id/delete_admin', to: 'users#delete_admin', as: 'delete_admin'
    post '/users/:id/kick', to: 'users#kick', as: 'kick_member'
    get '/invitations/:id/accept', to: 'invitations#accept', as: 'accept_invitation'
  end

  resources :tasks do
    resources :notes
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post '/assign/:id', to: 'tasks#assign', as: 'assign_user'
  post '/unassign/:id', to: 'tasks#unassign', as: 'unassign_user'
  get '/tasks/:id/complete', to: 'tasks#complete', as: 'complete'
  get '/tasks/:id/incomplete', to: 'tasks#incomplete', as: 'incomplete'

  get '/auth/facebook/callback', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
