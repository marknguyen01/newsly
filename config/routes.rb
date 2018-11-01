Rails.application.routes.draw do
    devise_scope :user do
    post "/user/login" => "session#create"
    get "/user/register" => "devise/registrations#new"
    post "/user/register" => "devise/registrations#create"
    get "/user/logout" => "devise/sessions#destroy"
  end
  # devise_for :users,  :controllers => { registrations: 'registration' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'articles#index', :as => :articles_index
  get '/articles/:id' => 'articles#show', :as => :articles_show
  get '/comments/:id/new' => 'comments#new'
  post '/comments/create' => 'comments#create'
  post '/like/create' => 'articles#like'
end
