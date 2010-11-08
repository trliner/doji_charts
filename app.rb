require 'rubygems'
require 'sinatra'
require 'json'

get '/' do
  @page_title = "Doji Charts"
  erb :'index.html'
end