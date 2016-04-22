Rails.application.routes.draw do

  # resources :users, only: :show

  get "profile" => "users#show", :as => 'profile'

  resources :wikis
    # resources :collaborators, only: [:create, :destroy]


  devise_for :users

  root 'welcome#index'

  resources :charges, only: [:new, :create]

  post "users/downgrade" => 'users#downgrade', :as => 'downgrade_user'

  resources :collaborators, only: [:create, :destroy]


end
