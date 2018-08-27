class UserTrip < ApplicationRecord
  belongs_to :user
  belongs_to :trip
end
