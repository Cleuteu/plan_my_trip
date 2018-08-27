class BranchEvent < ApplicationRecord
  belongs_to :branch
  belongs_to :event
end
