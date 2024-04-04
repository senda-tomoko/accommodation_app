# lib/tasks/import_rooms.rake
require 'csv'

namespace :import do
  desc "Import rooms from CSV file"
  task rooms: :environment do
    csv_path = Rails.root.join('lib', 'tasks', 'data', 'rooms.csv')

    CSV.foreach(csv_path, headers: true) do |row|
      Room.create!(
        name: row['name'],
        address: row['address'],
        detail: row['detail'],
        price: row['price'],
        image_path: row['image_path']
      )
    end

    puts "Rooms imported successfully!"
  end
end
