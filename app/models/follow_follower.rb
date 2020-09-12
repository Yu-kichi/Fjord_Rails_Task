# frozen_string_literal: true

class FollowFollower < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :following, presence: true
  validates :follower, presence: true
end
