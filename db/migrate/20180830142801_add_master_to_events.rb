class AddMasterToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :master, :boolean, default: false
  end
end
