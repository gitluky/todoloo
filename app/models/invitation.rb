class Invitation < ApplicationRecord
  belongs_to :group
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :recipient_id, presence: true
  validates :recipient_id, uniqueness: { scope: :group_id }

  def recipient_email=(email)
    self.recipient = User.find_by(email: email)
  end

  def recipient_email
    self.recipient ? self.recipient.name : nil
  end

end
