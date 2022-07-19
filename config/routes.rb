Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#welcome'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'
  get '/dashboard', to: 'users#show'

  # namespace :users do
  #   patch  '/edit', to: 'users#edit'
  # end

  resources :users, only: %i[create edit update index] do
     resources :movies, only: %i[index show] do
       resources :viewing_partys, only: %i[new create]
     end

     get '/discover', to: 'users#discover'

  end
end
