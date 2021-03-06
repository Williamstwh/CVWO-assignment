Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'

  resources :users, only: [:new, :create]

  namespace :my do
      resource :account, only: [:show, :edit, :update, :delete]
      resources :todos
  end

  namespace :admin do
      resources :users
  end

  resource :session, only: [:new, :create, :destroy]
end
