require 'sequel'
require 'date'

DB = Sequel.postgres
DB.extension :pg_array

if DB.tables.empty?
  DB.create_table :reports do
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
  end
end
