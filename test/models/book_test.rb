# frozen_string_literal: true

require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "editable?" do
    alice = FactoryBot.create(:user)
    bob = FactoryBot.create(:user, name: "Bob", email: "bob@example.com", password: "password", uid: "bobtest")
    book_1 = FactoryBot.create(:book, user: alice)
    book_2 = FactoryBot.create(:book, user: bob)

    assert book_1.editable?(alice)
    assert_not book_1.editable?(bob)
    assert book_2.editable?(bob)
    assert_not book_2.editable?(alice)
  end
end
