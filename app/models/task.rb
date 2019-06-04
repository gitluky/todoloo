class Task < ApplicationRecord
  belongs_to :group
  belongs_to :created_by
  belongs_to :assigned_to
  has_many :notes
end
