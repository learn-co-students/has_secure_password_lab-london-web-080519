Rails.application.routes.draw do
  resources :users
  get '/welcome', to: 'users#welcome', as: :welcome
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
