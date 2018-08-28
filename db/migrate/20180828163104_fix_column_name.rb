class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :branch_events, :event_position, :parent_event
  end
end
