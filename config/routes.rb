Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  root 'static_pages#home'
  get 'static_pages/home'
  get '/about', to: 'static_pages#about' #「/about」というアドレスにアクセスしてきたら、「static_pagesのabout」を呼び出す
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end
end