class Task < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :notes
end
