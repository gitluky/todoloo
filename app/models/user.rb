class User < ApplicationRecord
  has_many :tasks
  has_many :announcments
  has_many :recieved_invitations, class_name: "Invitation", foreign_key: 'recipient_id'
  has_many :sent_invitations, class_name: "Invitation", foreign_key: 'sender_id'
  has_many :groups, through: :groups_users
  has_one_attached :avatar

  validates :email, uniqueness: true

  has_secure_password

end
