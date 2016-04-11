Rails.application.routes.draw do

  resources :wikis

  devise_for :users

  root 'welcome#index'

  resources :charges, only: [:new, :create]

end
