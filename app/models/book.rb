# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :comments, as: :commentable
  mount_uploader :picture, PictureUploader
  validates :title, presence: true
  belongs_to :user
  scope :order_by_recent, -> { order(updated_at: :desc) }

  def editable?(current_user)
    user == current_user
  end
end
