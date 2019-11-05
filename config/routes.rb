# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  get 'dashboard' => 'dashboard#show'

  delete 'logout' => 'logout#logout'
  get 'auth/oauth2/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'

  resources :profiles do
    resources :memberships
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
