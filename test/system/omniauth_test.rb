# frozen_string_literal: true

require "application_system_test_case"

class OmniauthTest < ApplicationSystemTestCase
  test "アカウント登録ページの表示(index)" do
    visit new_user_registration_path
    assert_text "GitHubでログイン"
  end

  test "GitHubでログイン" do
    sign_in_as(FactoryBot.create(:user))
    assert_text "Github アカウントによる認証に成功しました。"
  end
end
