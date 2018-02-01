require 'roda'

require 'pry' if ENV['RACK_ENV'] == 'development'

require_relative 'models'

class App < Roda

  plugin :multi_route

  Dir['./routes/*.rb'].each{|file| require file }

  route do |r|
    r.multi_route
  end
end
