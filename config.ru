ENV["RACK_ENV"] ||= "development"
require 'app'

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/#{RACK_ENV.downcase}.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application