# frozen_string_literal: true

require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "editable?" do
    alice = FactoryBot.create(:user)
    bob = FactoryBot.create(:user, name: "Bob", email: "bob@example.com", password: "password", uid: "bobtest")
    book_1 = FactoryBot.create(:book, user: alice)

    comment_1 = book_1.comments.create(body: "いいね", user: alice)
    comment_2 = book_1.comments.create(body: "いいね", user: bob)

    assert comment_1.editable?(alice)
    assert_not comment_1.editable?(bob)
    assert comment_2.editable?(bob)
    assert_not comment_2.editable?(alice)
  end
end
