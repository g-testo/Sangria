Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'd', controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        :omniauth_callbacks => "users/omniauth_callbacks"
      }

  authenticate :user do
    resources :recipes, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :users, only: [:show]
  resources :recipes, only: [:index, :show]

  root 'static_pages#home'
  get '/about' => 'static_pages#about'

  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'

end
