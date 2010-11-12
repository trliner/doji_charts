require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
Bundler.require(:default)

require 'app/base'

# /2010-10-22/2010-10-28
get '/:start_date/:end_date' do
  range = StockQuote.range(params[:start_date], params[:end_date])
  @page_title = "Doji Charts"
  @chart_title = StockQuote.chart_title(range)
  @data = StockQuote.chart_data(:candle, range)
  @labels = StockQuote.chart_data(:label, range)
  erb :'index.html'
end