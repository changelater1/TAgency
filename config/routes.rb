Rails.application.routes.draw do
  resources :profiles, only: [:show, :edit, :update]

  devise_for :users,
      controllers: {
         omniauth_callbacks: 'users/omniauth_callbacks'
      }

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'home#index'
  get '/users/auth/:provider/callback', to: 'omniauth_callbacks#google_oauth2'
  get '/my_profile', to: 'profiles#my_profile'
end
