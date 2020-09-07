# frozen_string_literal: true
#ユーザープロフィール作成
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
  user.portrait.attach(io: File.open("public/piyo.jpg"), filename: "piyo.jpg")
end

#ユーザーがbookを投稿する
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

#user同士のフォロー関係を作成
users = User.all
user  = users.first
followings = users[1..10]
3.times do |n|
  followings.each { |following| following.active_relationships.create(follower_id: user.id+n)}
end
