# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i(github)

  validates :uid, presence: true, uniqueness: { scope: :provider }
  # 通常サインアップ時のuid用
  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_github_oauth(auth, signed_in_resource = nil)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  has_many :books, dependent: :destroy
  validates :name, presence: true
  validates :address, length: { maximum: 80 }
  validates :introduction, length: { maximum: 500 }
  validates :zip_code,  length: { maximum: 10 }
end
