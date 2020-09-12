# frozen_string_literal: true

class ChangeColumnsAddNotnullOnFollowFollowers < ActiveRecord::Migration[6.0]
  def change
    change_column :follow_followers, :following_id, :integer, null: false
    change_column :follow_followers, :follower_id, :integer, null: false
  end
end
