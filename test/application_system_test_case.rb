# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  # ブラウザを非表示にしたい時は下のコメントアウトを外しそちらを使う。
  # driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  include SignInHelper
end
