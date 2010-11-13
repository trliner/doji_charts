require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
Bundler.require(:default)

require 'app/base'

get '/' do
  end_date = StockQuote.most_recent.date
  start_date = end_date - 7
  redirect "/#{start_date}/#{end_date}"
end

# /2010-10-22/2010-10-28
get '/:start_date/:end_date' do
  @start_date = params[:start_date]
  @end_date = params[:end_date]
  range = StockQuote.range(@start_date, @end_date)
  @page_title = "Doji Charts"
  @chart_title = StockQuote.chart_title(range)
  @data = StockQuote.chart_data(:candle, range)
  @labels = StockQuote.chart_data(:label, range)
  erb :'index.html'
end

post '/' do
  start_date = params['post']['start_date']
  end_date = params['post']['end_date']
  redirect "/#{start_date}/#{end_date}"
end