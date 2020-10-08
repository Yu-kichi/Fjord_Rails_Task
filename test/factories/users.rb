
# FactoryBot.define do
#   factory :user, aliases: [:owner] do
#     provider {"github"}
#     name {"Alice"}
#     uid {"123458"}
#     email {"alice@example.com"}
#     password {"password"}
#   end
# end

FactoryBot.define do
  factory :user do 
    name {"Alice"}
    email {"alice@example.com"}
    password {"password"}
    uid {"123458"}
  end
end
