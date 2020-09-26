# frozen_string_literal: true

class ChangeColumnCommentBodyNotNull < ActiveRecord::Migration[6.0]
  def up
    change_column :comments, :body, :string, null: false
  end

  def down
    change_column :comments, :body, :string, null: true
  end
end
