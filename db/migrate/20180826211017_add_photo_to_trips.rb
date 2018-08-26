class AddPhotoToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :photo, :string
  end
end
