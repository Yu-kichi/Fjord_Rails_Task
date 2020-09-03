# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope "(:locale)", locale: /en|ja/ do
    root "books#index"
    resources :books
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      registrations: "users/registrations",
      sessions:      "users/sessions",
      passwords:     "users/passwords",
     }
    resources :users, except: [:new, :create] do
      resources :books, only: [:index]
    end
  end
end
