# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
   test "followed_by?" do
     me = User.create(name:"yuki",email: "yuki@example.com",password: "password",uid: "abc")
     she = User.create(name:"saki",email: "saki@example.com",password: "password",uid: "kbo")

     assert me.active_relationships.create(follower_id: she.id)
     assert_equal(me.active_relationships.create(follower_id: she.id),she.followed_by?(me))
   end
end
