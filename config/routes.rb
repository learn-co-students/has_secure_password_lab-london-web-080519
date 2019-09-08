Rails.application.routes.draw do
  root 'welcome#homepage'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  
  resources :users, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
