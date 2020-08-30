# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  validates :name, presence: true
  validates :address, length: { maximum: 80 }
  validates :introduction, length: { maximum: 500 }
  validates :zip_code,  length: { maximum: 10 }
end
