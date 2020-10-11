# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    user
    title { "よくわかるgit" }
    author { "賢いさる" }
    memo { "楽しいなあ" }
  end
end
