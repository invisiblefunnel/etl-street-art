require 'dotenv';Dotenv.load
require 'sequel'
require 'date'
require 'uri'

url = URI(ENV.fetch('DATABASE_URL'))
config = {}
config[:database] = url.path[1..-1]
config[:port]     = url.port
config[:host]     = url.host
config[:user]     = url.user if url.user
config[:password] = url.password if url.password

DB = Sequel.postgres(config)
DB.extension :pg_array
DB.extension :pagination

DB.create_table? :reports do
  primary_key :id
  String :case_id
  DateTime :opened_at
  DateTime :closed_at
  String :status
  String :address
  String :category
  String :type
  String :details
  String :district
  String :neighborhood
  Float :lat
  Float :lon

  index :case_id, unique: true
end
