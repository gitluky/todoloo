Rails.application.routes.draw do
  root 'application#index'
  resources :notes
  resources :tasks
  resources :announcements
  resources :invitations
  resources :groups
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
