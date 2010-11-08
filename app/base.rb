RACK_ENV = ENV["RACK_ENV"] ||= "development"
ROOT_DIR = File.expand_path("#{File.dirname(__FILE__)}/..")

def root_path(*args)
  File.join(ROOT_DIR, *args)
end

require 'config/env'