# frozen_string_literal: true

class CreateFollowFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_followers do |t|
      t.integer :following_id
      t.integer :follower_id

      t.timestamps
    end
    add_index :follow_followers, :following_id
    add_index :follow_followers, :follower_id
    add_index :follow_followers, [:following_id, :follower_id], unique: true
  end
end
