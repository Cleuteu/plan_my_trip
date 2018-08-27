class Trip < ApplicationRecord
  has_many :user_trips
  has_many :branches, dependent: :destroy
  has_many :users, through: :user_trips
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_location, presence: true
  validates :end_location, presence: true
end
