# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :comments, as: :commentable
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

end
