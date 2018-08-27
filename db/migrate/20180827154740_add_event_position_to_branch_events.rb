class AddEventPositionToBranchEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :branch_events, :event_position, :integer
  end
end
