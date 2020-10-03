# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :body, presence: true
  scope :order_by_recent, -> { order(updated_at: :desc) }

  def editable?(current_user)
    user == current_user
  end
end
