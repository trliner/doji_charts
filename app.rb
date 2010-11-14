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

post '/' do
  start_date = params['post']['start_date']
  end_date = params['post']['end_date']
  redirect "/#{start_date}/#{end_date}"
end

# /2010-10-22/2010-10-28
get '/:start_date/:end_date' do
  @start_date = params[:start_date]
  @end_date = params[:end_date]
  range = StockQuote.range(@start_date, @end_date)
  chart_data = StockQuote.chart_data(range)
  @page_title = "Doji Charts"
  @chart_title = chart_data[:title]
  @y_min = chart_data[:y_min]
  @y_max = chart_data[:y_max]
  @x_max = chart_data[:x_max]
  @data = chart_data[:candle]
  @labels = chart_data[:label]
  erb :'index.html'
end