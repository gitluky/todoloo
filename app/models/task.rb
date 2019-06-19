class Task < ApplicationRecord
  belongs_to :group
  belongs_to :created_by, class_name: 'User'
  belongs_to :assigned_to, class_name: 'User', optional: true
  has_many :notes

  def assigned?
    !!self.assigned_to_id
  end

  def assigned_user_email
    User.find_by(id: self.assigned_to).try('email')
  end

  def creator_user_email
    User.find_by(id: self.created_by).try('email')
  end

end
