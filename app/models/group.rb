class Group < ApplicationRecord
  has_many :tasks
  has_many :announcements
  has_many :invitations
  has_many :memberships
  has_many :users, through: :memberships

  has_one_attached :image

end
