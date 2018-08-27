class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.references :trip, foreign_key: true
      t.boolean :master

      t.timestamps
    end
  end
end
