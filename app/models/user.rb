require 'open-uri'
class User < ApplicationRecord
  has_many :created_tasks, class_name: "Task", foreign_key: 'created_by_id'
  has_many :assigned_tasks, class_name: "Task", foreign_key: 'assigned_to_id'
  has_many :announcements
  has_many :received_invitations, class_name: "Invitation", foreign_key: 'recipient_id'
  has_many :sent_invitations, class_name: "Invitation", foreign_key: 'sender_id'
  has_many :memberships
  has_many :groups, through: :memberships
  has_one_attached :avatar

  validates :email, uniqueness: true

  has_secure_password

  def self.find_or_create_by_oauth(oauth_hash)
    user = User.find_or_create_by(email: oauth_hash['info']['email']) do |u|
      u.uid = oauth_hash['uid']
      u.name = oauth_hash['info']['name']
      u.provider = oauth_hash['provider']
      u.password = SecureRandom.hex
    end
    avatar_image = open(oauth_hash['info']['image']+'?type=large')
    user.avatar.attach(io: avatar_image, filename: "avatar_#{user.id}.jpg", content_type: avatar_image.content_type)
    user.save
    user
  end
end
