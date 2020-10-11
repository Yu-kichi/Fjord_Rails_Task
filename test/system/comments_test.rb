# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  setup do
    FactoryBot.create(:book)
    Bob = FactoryBot.create(:user, name: "Bob", email: "bob@example.com", password: "password", uid: "bobtest")
    visit new_user_session_path
    fill_in "Eメール", with: "bob@example.com"
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
    assert_difference("Comment.count", 1) do
      click_button "登録する"
    end
    assert_text "コメントを作成しました！"
    assert_text "大変参考になりました"
  end

  test "Aliceの本の投稿に対するBobのコメントの編集をする(update_comment)" do
    visit root_path
    click_on "詳細"
    fill_in "comment_body", with: "大変参考になりました"
    click_button "登録する"

    visit root_path
    click_on "詳細"
    click_on "編集"

    fill_in "コメント", with: "めっちゃ面白い"
    click_button "更新する"

    assert_text "コメントを更新しました！"
    assert_text "めっちゃ面白い"
  end

  test "コメントを削除する(destroy_comment)" do
    visit root_path
    click_on "詳細"
    fill_in "comment_body", with: "大変参考になりました"
    click_button "登録する"

    visit root_path
    click_on "詳細"
    assert_difference("Comment.count", -1) do
      accept_confirm do
          click_on "削除"
        end
      assert_text "コメントを削除しました"
    end
  end
end
