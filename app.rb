require 'roda'

require_relative 'models'

class App < Roda
  plugin :csrf
  plugin :multi_route
end
