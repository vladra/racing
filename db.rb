require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/racing_dev')
