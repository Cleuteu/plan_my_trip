class Branch < ApplicationRecord
  belongs_to :trip
  has_many :branch_events
end
