# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i(github)

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
     user = User.find_by(provider: auth.provider, uid: auth.uid)
 
     unless user
       user = User.new(provider: auth.provider,
                       uid:      auth.uid,
                       name:     auth.info.name,
                       email:    auth.info.email,
                       password: Devise.friendly_token[0, 20]
       )
     end
     user.save
     user
  end

  has_many :books, dependent: :destroy
  validates :name, presence: true
  validates :address, length: { maximum: 80 }
  validates :introduction, length: { maximum: 500 }
  validates :zip_code,  length: { maximum: 10 }
end
