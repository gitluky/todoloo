class Group < ApplicationRecord
  has_many :tasks
  has_many :announcments
  has_many :invitations
  has_many :users, through: :groups_users
end
