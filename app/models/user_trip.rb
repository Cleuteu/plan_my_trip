class UserTrip < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  validates :user_id, presence: true
  validates :trip_id, presence: true
end
