# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    user
    title { "今日が最終日" }
    body { "楽しかった！" }
  end
end
