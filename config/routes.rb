Rails.application.routes.draw do
    root 'articles#index'
    
    resources :users, only: [:new, :create]
    get '/register', to: 'users#new'
    post '/register', to: 'users#create'
    
    resources :user_sessions, only: [:create, :destroy]
    get '/logout', to: 'user_sessions#destroy', as: :user_logout
    get '/login', to: 'user_sessions#new', as: :user_login
    # devise_for :users,  :controllers => { registrations: 'registration' }
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :articles, only: [:show, :index] do
        resources :comments
        put 'upvote', to: "articles#upvote"
        put 'downvote', to: "articles#downvote"
    end
end
