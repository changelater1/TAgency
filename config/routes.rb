Rails.application.routes.draw do
  devise_for :users,
      controllers: {
         omniauth_callbacks: 'users/omniauth_callbacks',
         sessions: 'users/sessions',
         registrations: 'users/registrations',
         passwords: 'users/passwords'

      }

  resources :profiles, only: [:show, :edit, :update, :destroy]
  resources :orders
  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'home#index'
  get '/users/auth/:provider/callback', to: 'omniauth_callbacks#google_oauth2'
  get '/my_profile', to: 'profiles#my_profile'
  get '/my_profile/orders', to: 'profiles#show_owned_orders'
  
end
