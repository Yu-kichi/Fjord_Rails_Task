# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    root "books#index"
    resources :books
  end
end
