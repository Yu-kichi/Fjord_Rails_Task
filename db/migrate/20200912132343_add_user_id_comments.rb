class AddUserIdComments < ActiveRecord::Migration[6.0]
  def up
    add_reference :comments, :user, null: false, index: true
  end
  def down
    remove_reference :comments, :user, index: true
  end
end
