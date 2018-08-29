class AddTripToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :trip, index: true
  end
end
