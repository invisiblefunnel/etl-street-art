require './data/schema'
require 'csv'

class SteetArtImporter < Struct.new(:table, :row)
  LAT_LON = /(-?\d+\.\d+), (-?\d+\.\d+)/

  def self.import(table, row)
    new(table, row).import
  end

  def import
    table.insert(to_h)
  end

  def to_h
    {
      case_id: row['CaseID'],
      opened_at: row['Opened'],
      closed_at: row['Closed'],
      status: row['Status'],
      address: row['Address'],
      category: row['Category'],
      type: row['Request Type'],
      details: row['Request Details'],
      district: row['Supervisor District'],
      neighborhood: row['Neighborhood'],
      lat: lat,
      lon: lon
    }
  end

  def point
    @point ||= LAT_LON.match(row['Point'])
  end

  def lat
    point[1].to_f
  end

  def lon
    point[2].to_f
  end
end

count = 0
CSV.foreach('./data/Graffiti_SF311_Reports.csv', headers: true) do |row|
  SteetArtImporter.import(DB[:reports], row)

  count +=1
  puts "Imported: #{count}" if count % 100 == 0
end
