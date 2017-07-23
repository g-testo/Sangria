Rails.application.routes.draw do

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

  authenticate :user do
    resources :recipes, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :recipes, only: [:index, :show]

  root 'static_pages#home'
  get '/about' => 'static_pages#about'

  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'

end
