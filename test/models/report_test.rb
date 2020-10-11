# frozen_string_literal: true

require "test_helper"

class ReportTest < ActiveSupport::TestCase
  test "editable?" do
    alice = FactoryBot.create(:user)
    bob = FactoryBot.create(:user, name: "Bob", email: "bob@example.com", password: "password", uid: "bobtest")
    report_1 = FactoryBot.create(:report, user: alice)
    report_2 = FactoryBot.create(:report, user: bob)

    assert report_1.editable?(alice)
    assert_not report_1.editable?(bob)
    assert report_2.editable?(bob)
    assert_not report_2.editable?(alice)
  end
end
