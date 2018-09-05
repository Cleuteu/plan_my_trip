class AddPhotoToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :photo, :string
  end
end
