class Trip < ApplicationRecord
  has_many :user_trips
  has_many :branches
  belong_to :user
end
