# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :comments, as: :commentable
  mount_uploader :picture, PictureUploader
  validates :title, presence: true
  belongs_to :user
  scope :recent, -> { order(updated_at: :desc) }
end
