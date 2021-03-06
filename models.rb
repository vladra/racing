require_relative 'db'

Sequel::Model.plugin :json_serializer

if ENV['RACK_ENV'] == 'development'
  Sequel::Model.cache_associations = false
end

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each {|file| require file }

if ENV['RACK_ENV'] == 'development'
  require 'logger'
  DB.loggers << Logger.new($stdout)
else
  DB.freeze
end
