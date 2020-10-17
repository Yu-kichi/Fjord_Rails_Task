# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = FactoryBot.create(:book)
    visit new_user_session_path
    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  test "ログインしたら本の一覧画面になる(index)" do
    visit root_path
    assert_selector "h1", text: "書籍一覧"
  end

  test "新規投稿する(create_book)" do
    visit root_path
    click_on "新規作成"

    fill_in "作品名", with: "Ruby超入門"
    fill_in "著者名", with: "igaiga"
    fill_in "メモ", with: "rubyのことがよくわかる！"

    assert_difference("Book.count", 1) do
      click_button "登録する"
    end

    assert_text "本を作成しました！"
    assert_text "Ruby超入門"
    assert_text "igaiga"
    assert_text "rubyのことがよくわかる！"
  end

  test "本の編集をする(update_book)" do
    visit root_path
    click_on "編集"

    fill_in "作品名", with: "Ruby超入門ですよ"
    fill_in "著者名", with: "igaigaですよ"
    fill_in "メモ", with: "rubyのことがよくわかりますよ！"
    click_button "更新する"

    assert_text "本を更新しました！"
    assert_text "Ruby超入門ですよ"
    assert_text "igaigaですよ"
    assert_text "rubyのことがよくわかりますよ！"
  end

  test "本を削除する(destroy_book)" do
    visit root_path
    assert_difference("Book.count", -1) do
      accept_confirm do
          click_on "削除"
        end
      assert_text "本を削除しました"
    end
  end
end
