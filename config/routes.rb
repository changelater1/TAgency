Rails.application.routes.draw do
  require 'sidekiq/web'
# or require 'sidekiq/pro/web'
# or require 'sidekiq-ent/web'
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  
  
  root 'home#index'
  get '/:locale', to: 'home#index'

  
  devise_for :users, skip: [:sessions, :registrations, :passwords, :unlocks, :confirmations], controllers:{
    omniauth_callbacks: 'users/omniauth_callbacks'
}
  scope ":locale", defaults: {locale: "en"} do
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      unlocks: 'users/unlocks',
      confirmations: 'users/confirmations',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

    resources :profiles, only: [:show, :edit, :update, :destroy] do
      post 'comment', to: 'comments#profile_comment'
      collection do
        get :owned_orders
      end
    end
    resources :orders do
      post 'comment', to: 'comments#order_comment'
      resources :responses, only: [:create]
      member do
        get :select_performer
        patch :assign_performer
        patch :accept
        patch :complete
      end
    end
    
    
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    # Defines the root path route ("/")
    
    get '/users/auth/:provider/callback', to: 'omniauth_callbacks#google_oauth2' #, as: 'user_google_oauth2_omniauth_authorize'
    get '/my_profile', to: 'profiles#my_profile'
    
    #get '/my_profile/orders', to: 'profiles#owned_orders'
    
  end
end
