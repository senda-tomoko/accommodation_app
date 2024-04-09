class AddCsvImportedToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :csv_imported, :boolean
  end
end
