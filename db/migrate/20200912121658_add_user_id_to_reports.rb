class AddUserIdToReports < ActiveRecord::Migration[6.0]
  def up
    add_reference :reports, :user, null: false, index: true
  end
  def down
    remove_reference :reports, :user, index: true
  end
end
