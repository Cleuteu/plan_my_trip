class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :parent, foreign_key: { to_table: :events }
      t.references :child, foreign_key: { to_table: :events }

      t.timestamps
    end
  end
end
