Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'articles#index', :as => :articles_index
  get '/articles/:id' => 'articles#show', :as => :articles_show
  get '/comments/:id/new' => 'comments#new'
  post '/comments/create' => 'comments#create'
  post '/like/create' => 'articles#like'
end
