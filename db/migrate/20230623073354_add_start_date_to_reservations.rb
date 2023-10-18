class AddStartDateToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :start_date, :datetime
  end
end
