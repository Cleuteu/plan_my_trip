class Event < ApplicationRecord
  has_many :branch_events, dependent: :destroy
  has_many :branches, through: :branch_events

  validates :name, presence: true, length: { maximum: 15 }
  validates :category, presence: true
  # validates :location, presence: true
  validates :date, presence: true
  validates :duration, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
