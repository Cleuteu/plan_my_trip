class Event < ApplicationRecord
  # has_many :branch_events
  # has_many :branches, through: :branch_events
  has_many :relationships_as_parent, foreign_key: :parent_id, class_name: "Relationship"
  has_many :children, through: :relationships_as_parent, source: :child

  has_many :relationships_as_child, foreign_key: :child_id, class_name: "Relationship"
  has_many :parents, through: :relationships_as_child, source: :parent

  validates :name, presence: true, length: { maximum: 25 }
  validates :category, presence: true
  # validates :location, presence: true
  validates :date, presence: true
  validates :trip_id, presence: true

  validates :photo, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  mount_uploader :photo, PhotoUploader
end
