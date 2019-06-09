class Group < ApplicationRecord
  has_many :tasks
  has_many :announcements
  has_many :invitations
  has_many :memberships
  has_many :users, through: :memberships
  belongs_to :last_edited_by, class_name: 'User'

  has_one_attached :image

  scope :has_member, ->(user_id) { joins(:memberships).where(memberships: { user_id: user_id} ) }


end
