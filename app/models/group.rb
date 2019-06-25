class Group < ApplicationRecord
  has_many :tasks
  has_many :announcements
  has_many :invitations
  has_many :memberships
  has_many :users, through: :memberships
  belongs_to :last_edited_by, class_name: 'User', optional: true

  has_one_attached :image

  scope :group_admins, ->(user) { joins(:memberships).where(memberships: { admin: true })}

  def recent_announcements
    self.announcements.where('created_at > ?', 1.week.ago)
  end

  def tasks_assigned_to_user(user)
    self.tasks.where(assigned_to_id: user.id)
  end

end
