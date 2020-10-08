# frozen_string_literal: true
# FactoryBot.define do
#   factory :book do
#     owner
#     sequence(:name) { |i| "本の名前#{i}" }
#     sequence(:author) { |i| "本の著者#{i}" }
#     start_at {rand(1..30).days.from_now) }
#     end_at {start_at + rand(1..30).hours }
#   end
# end

FactoryBot.define do
  factory :book do
    user
    title {"よくわかるgit"}
    author {"賢いさる"}
    memo {"楽しいなあ"}
  end
end
