require 'logger'
LOGGER = Logger.new(root_path('log', "#{RACK_ENV}.log"))

set :views, root_path("app", "views")