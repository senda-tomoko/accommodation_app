require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'rooms.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  Room.create!(row.to_hash)
end
