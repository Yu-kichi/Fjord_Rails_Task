# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "followed_by?" do
    me = User.create(name: "yuki", email: "yuki@example.com", password: "password", uid: "abc")
    she = User.create(name: "saki", email: "saki@example.com", password: "password", uid: "def")

    me.active_relationships.create(follower_id: she.id)
    assert she.followed_by?(me)
    assert_not me.followed_by?(she)
  end

  test "self.find_for_github_oauth(auth), 登録済みのユーザーがいる場合、登録されてるユーザーを見つける。" do
    alice = FactoryBot.create(:user)
    auth_user_1 = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "123456",
    })
    user_1 = User.find_for_github_oauth(auth_user_1)
    assert user_1 == alice
  end

  test "self.find_for_github_oauth(auth), 登録済みのユーザーがいない場合、新規のユーザーを作成" do
     auth_user_2 = OmniAuth::AuthHash.new({
       provider: "github",
       uid: "7890",
       info: { name: "tom" },
       info: { email: "tom@example.com" }
     })
     user_2 = User.find_for_github_oauth(auth_user_2)
     assert_equal(user_2.email, "tom@example.com")
     assert User.find_by(uid: "7890")
   end
end
