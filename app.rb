require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
Bundler.require(:default)

require 'app/base'

get '/' do
  @page_title = "Doji Charts"
  @chart_title = 'SPY: 10/25/10 - 10/28/10'
  @data = StockQuote.chart_data("2010-10-18", "2010-10-28")
  @labels = [
    ['10/28', 5],
    ['10/27', 4],
    ['10/26', 3],
    ['10/25', 2],
    ['10/22', 1]
  ]
  erb :'index.html'
end