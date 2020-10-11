# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    FactoryBot.create(:report)
    visit new_user_session_path
    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  test "日報一覧画面の表示(index)" do
    visit root_path
    click_on "日報"
    assert_selector "h1", text: "日報一覧"
  end

  test "新規投稿する(create_report)" do
    visit root_path
    click_on "日報"
    click_on "新規作成"
    fill_in "タイトル", with: "最初の日報"
    fill_in "内容", with: "今日からキャンプに入るよ！"

    assert_difference("Report.count", 1) do
      click_button "登録する"
    end
    assert_text "日報を作成しました！"
    assert_text "最初の日報"
    assert_text "今日からキャンプに入るよ！"
  end

  test "日報の編集をする(update_report)" do
    visit root_path
    click_on "日報"
    click_on "編集"

    fill_in "タイトル", with: "３日目"
    fill_in "内容", with: "ちょっと慣れてきた"
    click_on "更新する"

    assert_text "日報を更新しました！"
    assert_text "３日目"
    assert_text "ちょっと慣れてきた"
  end

  test "本を削除する(destroy_book)" do
    visit root_path
    click_on "日報"
    assert_difference("Report.count", -1) do
      accept_confirm do
          click_on "削除"
        end
      assert_text "日報を削除しました！"
    end
  end
end
