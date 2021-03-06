include ChartDataHelpers

get '/' do
  symbol = Stock.first.symbol
  end_date = StockQuote.most_recent.date
  start_date = end_date - 7

  redirect "/#{symbol}/#{start_date}/#{end_date}/candle"
end

post '/' do
  symbol = params['post']['symbol']
  start_date = params['post']['start_date']
  end_date = params['post']['end_date']
  line_type = params['post']['line_type']

  redirect "/#{symbol}/#{start_date}/#{end_date}/#{line_type}"
end

# /SPY/2010-10-22/2010-10-28
get '/:symbol/:start_date/:end_date/:line_type' do
  @page_title = "Doji Charts"
  @line_type = params[:line_type].to_sym
  @symbol = params[:symbol]
  @start_date = params[:start_date]
  @end_date = params[:end_date]

  stock = Stock.first(:symbol => @symbol)
  range = stock.stock_quotes.range(@start_date, @end_date)
  @chart_data = chart_data(range, @line_type)

  erb :'index.html'
end