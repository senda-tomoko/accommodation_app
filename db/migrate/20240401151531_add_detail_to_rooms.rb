class AddDetailToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :detail, :text
  end
end
