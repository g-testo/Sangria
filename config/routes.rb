Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'd', controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: "users/passwords",
        :omniauth_callbacks => "users/omniauth_callbacks"
      }

  authenticate :user do
    resources :recipes, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :users, only: [:show, :destroy]
  resources :recipes, only: [:index, :show, :destroy]
  resources :ratings, only: :update
  resources :ingredients
  resources :recipes do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]


  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'admin' => 'admin#admin_page'
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'

end
