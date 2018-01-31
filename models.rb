require_relative 'db'

if ENV['RACK_ENV'] == 'development'
  Sequel::Model.cache_associations = false
end

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each {|file| require file }

if ENV['RACK_ENV'] == 'development'
  require 'logger'
  DB.loggers << Logger.new($stdout)
else
  Sequel::Model.freeze_descendents
  DB.freeze
end
