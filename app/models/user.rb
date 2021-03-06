# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :portrait
  has_many :books, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy
  # フォロー側
  # 外部キーには親の主キーを設定する。
  has_many :active_relationships, class_name: "FollowFollower", foreign_key: :following_id, dependent: :destroy
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」とする。
  has_many :followings, through: :active_relationships, source: :follower

  # フォローされる側、active側の逆となる
  has_many :passive_relationships, class_name: "FollowFollower", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

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

  validates :name, presence: true
  validates :address, length: { maximum: 80 }
  validates :introduction, length: { maximum: 500 }
  validates :zip_code,  length: { maximum: 10 }
  validates :portrait, content_type: ["image/png", "image/jpg", "image/jpeg"]

  def followed_by?(user)
    passive_relationships.exists?(following_id: user.id)
  end

  scope :order_by_recent, -> { order(updated_at: :desc) }
end
