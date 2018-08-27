class BranchEvent < ApplicationRecord
  belongs_to :branch
  belongs_to :event, dependent: :destroy

  validates :branch_id, presence: true
  validates :event_id, presence: true
  validates :event_position, presence: true
end
