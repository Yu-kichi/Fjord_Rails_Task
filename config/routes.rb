# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    root "books#index"
    # resources :books
    # resources :books do
    #  resource :user_books, only: [:create, :destroy]
    # end
    # これでuser/id/booksでそのユーザーごとの表示になる、ただしここにおくとuserのログアウトができなくなる。
    # resources :users do
    #  resources :books, only:[:index]
    # end
    resources :books
    devise_for :users, controllers: {
      registrations: "users/registrations",
      sessions:      "users/sessions",
     }
    resources :users, except: [:new, :create] do
      resources :books, only: [:index]
    end
  end
end
