class BranchEvent < ApplicationRecord
  belongs_to :branch
  belongs_to :event

  validates :branch_id, presence: true
  validates :event_id, presence: true
end
