class CreateUserTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :user_trips do |t|
      t.references :user, foreign_key: true
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
