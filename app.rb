require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
Bundler.require(:default)

require 'app/base'

get '/' do
  range = StockQuote.range("2010-10-1", "2010-10-28")
  @page_title = "Doji Charts"
  @chart_title = StockQuote.chart_title(range)
  @data = StockQuote.chart_data(:candle, range)
  @labels = StockQuote.chart_data(:label, range)
  erb :'index.html'
end