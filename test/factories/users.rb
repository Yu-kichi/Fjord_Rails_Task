# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    provider { "github" }
    name { "Alice" }
    uid { "123456" }
    email { "alice@example.com" }
    password { "password" }
    zip_code { "2345678" }
    address { "鳥取" }
    introduction { "like sushi" }
  end
end
