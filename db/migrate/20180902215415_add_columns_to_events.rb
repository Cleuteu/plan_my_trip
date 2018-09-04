class AddColumnsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :position_x, :integer
    add_column :events, :position_y, :integer
  end
end
