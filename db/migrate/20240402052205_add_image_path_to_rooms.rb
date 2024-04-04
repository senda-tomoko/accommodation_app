class AddImagePathToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :image_path, :string
  end
end
