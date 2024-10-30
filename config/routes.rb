Rails.application.routes.draw do
  #devise_for :users

  devise_for :users,
      controllers: {
         omniauth_callbacks: 'users/omniauth_callbacks'
      }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'home#index'

  # namespace :users do
  #   get '/users/auth/:provider/callback', to: 'omniauth_callbacks#google_oauth2'
  # end

  get '/users/auth/:provider/callback', to: 'omniauth_callbacks#google_oauth2'
  #get '/auth/failure', to: redirect('/')
  #delete '/logout', to: 'sessions#destroy'
end
