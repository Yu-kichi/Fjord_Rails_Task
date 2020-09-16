# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  has_many :comments, as: :commentable, dependent: :destroy
  scope :recent, -> { order(updated_at: :desc) }
end
