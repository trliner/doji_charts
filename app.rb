require 'rubygems'
require 'bundler'
Bundler.setup

require 'sinatra'
Bundler.require(:default)

require 'app/base'

get '/' do
  symbol = Stock.first.symbol
  end_date = StockQuote.most_recent.date
  start_date = end_date - 7
  redirect "/#{symbol}/#{start_date}/#{end_date}"
end

post '/' do
  symbol = params['post']['symbol']
  start_date = params['post']['start_date']
  end_date = params['post']['end_date']
  redirect "/#{symbol}/#{start_date}/#{end_date}"
end

# /SPY/2010-10-22/2010-10-28
get '/:symbol/:start_date/:end_date' do
  line_type = params[:line_type] || :candle
  @symbol = params[:symbol]
  @start_date = params[:start_date]
  @end_date = params[:end_date]
  stock = Stock.first(:symbol => @symbol)
  range = stock.stock_quotes.range(@start_date, @end_date)
  chart_data = StockQuote.chart_data(range, line_type)
  @page_title = "Doji Charts"
  @chart_title = chart_data[:title]
  @y_min = chart_data[:y_min]
  @y_max = chart_data[:y_max]
  @x_max = chart_data[:x_max]
  @data = chart_data[line_type]
  @labels = chart_data[:label]
  @chart_properties = chart_data[:properties]
  erb :'index.html'
end