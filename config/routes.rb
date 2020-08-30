# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions:      "users/sessions",
    passwords:     "users/passwords",
    omniauth_callbacks:  "users/omniauth_callbacks" 
   }
  scope "(:locale)", locale: /en|ja/ do
    #root :to => 'oauth_test#index'
    root "books#index"
    resources :books
    resources :users, except: [:new, :create] do
      resources :books, only: [:index]
    end
  end
end
