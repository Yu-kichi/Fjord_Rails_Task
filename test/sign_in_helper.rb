module SignInHelper
  def sign_in_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      user.provider,
      uid: user.uid,
      info: {nickname: user.name}
    )
    visit new_user_session_path
    #visit new_user_registration_path
    click_on "GitHubでログイン"
    @current_user = user
  end

  def current_user
    @current_user
  end
end