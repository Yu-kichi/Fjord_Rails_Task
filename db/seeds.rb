# frozen_string_literal: true
10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  address = Faker::Address.city
  User.create!(name: name,
               introduction: "#{name}ですよろしく！",
               email: email,
               address: address,
               zip_code: 21345678,
               password: "password"
               )
end

  title = Faker::Book.title
  author = Faker::Book.author
  n = 1
  User.all.each do |user|
  user.books.create!(title: title,
               memo: "#{n+1}冊目楽しいなあ〜",
               author: author,
               picture: nil,
               )
  end

