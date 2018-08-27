class Event < ApplicationRecord
  has_many :branch_events, dependent: :destroy
  has_many :branches, through: :branch_events

  validates :name, presence: true, length: { maximum: 15 }
  validates :type, presence: true
  validates :location, presence: true
  validates :date, presence: true
  validates :duration, presence: true



end
