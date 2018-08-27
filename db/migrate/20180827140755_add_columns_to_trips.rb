class AddColumnsToTrips < ActiveRecord::Migration[5.2]
  def change
    add_reference :trips, :user, foreign_key: true
    add_column :trips, :total_price, :integer
  end
end
