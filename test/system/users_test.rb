# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    FactoryBot.create(:user)
  end

  test "アカウント登録ページの表示(index)" do
    visit new_user_registration_path
    assert_selector "h1", text: "アカウント登録"
  end

  test "新規登録する(create_user)" do
    visit new_user_registration_path
    fill_in "名前", with: "Bob"
    fill_in "Eメール", with: "bob@example.com"
    fill_in "パスワード", with: "password"
    # (確認用)が見つからないのでここだけfindを使う。
    find('input[data-test="confirm"]').set("password")

    assert_difference("User.count", 1) do
      click_button "アカウント登録"
    end
  end

  test "ユーザー詳細を表示する(show)" do
    visit root_path
    click_on "ユーザー"
    click_on "Alice"

    assert_text "Alice"
    assert_text "alice@example.com"
    assert_text "2345678"
    assert_text "鳥取"
    assert_text "like sushi"
  end

  test "ユーザー情報の編集をする(update)" do
    visit new_user_session_path
    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    visit root_path
    click_on "Alice"
    click_on "編集"
    fill_in "名前", with: "Charlie"
    fill_in "Eメール", with: "charlie@example.com"
    fill_in "住所", with: "イギリス"
    fill_in "郵便番号", with: "2345678"
    fill_in "自己紹介文", with: "Like Football"
    click_button "更新する"

    assert_text "Userを更新しました！"
    assert_text "Charlie"
    assert_text "charlie@example.com"
    assert_text "イギリス"
    assert_text "2345678"
    assert_text "Like Football"
  end

  test "ユーザーの削除(destroy)" do
    visit new_user_session_path
    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    visit root_path
    click_on "Alice"
    click_on "パスワードを変更"

    assert_difference("User.count", -1) do
      accept_confirm do
        click_on "アカウント削除"
      end
      assert_text "アカウントを削除しました。またのご利用をお待ちしております。"
    end
  end
end
