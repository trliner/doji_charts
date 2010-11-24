FileUtils.mkdir_p 'log' unless File.exists?('log')
require 'app'

log = File.new("log/#{RACK_ENV.downcase}.log", "a+")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application