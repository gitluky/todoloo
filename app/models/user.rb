require 'open-uri'
class User < ApplicationRecord
  has_many :tasks
  has_many :announcments
  has_many :recieved_invitations, class_name: "Invitation", foreign_key: 'recipient_id'
  has_many :sent_invitations, class_name: "Invitation", foreign_key: 'sender_id'
  has_many :groups, through: :groups_users
  has_one_attached :avatar

  validates :email, uniqueness: true

  has_secure_password

  def self.find_or_create_by_oauth(oauth_hash)
    user = User.find_or_create_by(email: oauth_hash['email']) do |u|
      u.uid = oauth_hash['uid']
      u.name = oauth_hash['info']['name']
      u.provider = oauth_hash['info']['provider']
      u.password = SecureRandom.hex
    end
    avatar_image = open(oauth_hash['info']['image']+'?type=large')
    user.avatar.attach(io: avatar_image, filename: "avatar_#{user.id}.jpg", content_type: avatar_image.content_type)
    user.save
    user
  end
end
