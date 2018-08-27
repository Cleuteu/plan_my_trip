class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :type
      t.boolean :confirmed
      t.string :location
      t.date :date
      t.integer :duration
      t.text :description
      t.string :url
      t.integer :grid_location_x
      t.integer :grid_location_y

      t.timestamps
    end
  end
end
