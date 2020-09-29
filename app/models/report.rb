# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :comments, as: :commentable
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  scope :order_by_recent, -> { order(updated_at: :desc) }

  def editable?(current_user)
    if current_user
      user.id == current_user.id
    end
  end
end
