class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :category
      t.boolean :confirmed, default: false
      t.string :location
      t.date :date
      t.integer :duration
      t.text :description
      t.string :url
      t.timestamps
    end
  end
end
