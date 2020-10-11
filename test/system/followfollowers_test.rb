# frozen_string_literal: true

require "application_system_test_case"
class FollowFollowersTest < ApplicationSystemTestCase
  setup do
    Bob = FactoryBot.create(:user, name: "Bob", email: "bob@example.com", password: "password", uid: "bobtest", zip_code: "2345678", address: "鳥取", introduction: "like sushi")
    Alice = FactoryBot.create(:user)

    visit new_user_session_path
    fill_in "Eメール", with: "bob@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  test "フォローする(create)" do
    visit root_path
    click_on "ユーザー"
    click_on "Alice"

    assert_difference("FollowFollower.count", 1) do
      click_on "フォローする"
    end
    assert_text "フォロー中"
  end

  test "フォローを外す(destroy)" do
    visit root_path
    click_on "ユーザー"
    click_on "Alice"
    click_on "フォローする"

    visit root_path
    click_on "ユーザー"
    click_on "Alice"
    assert_difference("FollowFollower.count", -1) do
      click_on "フォロー中"
    end
    assert_text "フォローする"
  end
end
