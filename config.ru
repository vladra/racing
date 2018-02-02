dev = ENV['RACK_ENV'] == 'development'

if dev
  require 'logger'
  logger = Logger.new($stdout)
end

require 'rack/cors'
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: %i[get post options]
  end
end

use Rack::Static, urls: {'/' => 'index.html'}, root: 'public'
use Rack::Static, urls: ['/css', '/js', '/fonts'], root: 'public'

require_relative 'app'
run App
