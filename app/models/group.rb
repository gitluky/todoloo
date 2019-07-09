class Group < ApplicationRecord
  has_many :tasks
  has_many :announcements
  has_many :invitations
  has_many :memberships
  has_many :users, through: :memberships
  belongs_to :last_edited_by, class_name: 'User', optional: true

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true

  def recent_announcements
    Announcement.posted_for_group_since(self.id, 1.week.ago).order( created_at: :desc ).limit(1)
  end

  def tasks_assigned_to_user(user)
    self.tasks.where(assigned_to_id: user.id, status: 'Assigned')
  end

  def admins
    User.joins(:memberships).where(memberships: { group: self, admin: true })
  end

  def non_admins
    User.joins(:memberships).where(memberships: { group: self, admin: false })
  end

  def available_tasks
    tasks.where(assigned_to_id: nil).where.not(status: 'Completed')
  end

  def assigned_tasks
    tasks.where.not(assigned_to_id: nil).where.not(status: 'Completed')
  end

  def completed_tasks
    tasks.where(status: 'Completed')
  end

  def recent_completed_tasks
    tasks.where(status: 'Completed').where('updated_at > ?', 1.week.ago).order(updated_at: :desc)
  end

end
