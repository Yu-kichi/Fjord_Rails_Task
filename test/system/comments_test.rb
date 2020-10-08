# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    #FactoryBot.create(:user)
    FactoryBot.create(:book)
    visit new_user_session_path
    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  test "コメントの確認(show)" do 
    visit root_path
    click_on "詳細"
    assert_selector "h2", text: "コメントを投稿する"
  end
  
  test "コメントを新規投稿する(create_comment)" do
    visit root_path
    click_on "詳細"
    fill_in "comment_body", with: "大変参考になりました"
    assert_difference("Comment.count",1) do
      click_button "登録する"
    end
    assert_text "コメントを作成しました！"
    assert_text "大変参考になりました"
  end

end
