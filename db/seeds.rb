# frozen_string_literal: true

20.times do |n|
  name = Faker::Name.name
  address = Faker::Address.city
  uid = SecureRandom.uuid
  User.create!(name: name,
               introduction: "#{name}ですよろしく！",
               email: "#{n+1}@example.com",
               address: address,
               zip_code: 21345678,
               password: "password",
               uid: "uid+#{n}"
               )
  user = User.find(n+1)             
  user.portrait.attach(io: File.open('public/piyo.jpg'), filename: 'piyo.jpg')
end

User.all.each do |user|
  3.times do |n|
    title = Faker::Book.title
    author = Faker::Book.author
    user.books.create!(title: title,
                       memo: "#{n+1}冊目楽しいなあ〜",
                       author: author,
                       picture: nil,
                       )
  end
end
