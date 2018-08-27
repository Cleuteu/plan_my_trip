class Branch < ApplicationRecord
  belongs_to :trip
  has_many :branch_events, dependent: :destroy
  has_many :events, through: :branch_events

  validates :trip_id, presence: true
  validates :master, presence: true
end
