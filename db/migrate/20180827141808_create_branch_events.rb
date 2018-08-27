class CreateBranchEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :branch_events do |t|
      t.references :branch, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
