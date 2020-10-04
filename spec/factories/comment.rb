FactoryBot.define do
  factory :comment do
    user
    book
    body {"参考になりました"}
  end
end