# frozen_string_literal: true

class ChangeColumnBookTitleNotNull < ActiveRecord::Migration[6.0]
  def up
    change_column :books, :title, :string, null: false
  end

  # 変更前の状態
  def down
    change_column :books, :title, :string, null: true
  end
end
