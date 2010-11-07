require 'rubygems'
require 'sinatra'

get '/' do
  @page_title = "Doji Charts"
  erb :'index.html'
end