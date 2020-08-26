# frozen_string_literal: true

50.times do |n|
  title = Faker::Book.title
  author = Faker::Book.author
  Book.create!(title: title,
               memo: "#{n+1}冊目楽しいなあ〜",
               author: author,
               picture: nil,
               )
end
