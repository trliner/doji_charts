require 'rubygems'
require 'sinatra'
require 'json'

get '/' do
  @page_title = "Doji Charts"
  @chart_title = 'SPY: 10/25/10 - 10/28/10'
  @data = [
    # [time, [low, lower(open, last), open < last ? lower : higher,higher(open, last), high, 'green', 'red']]
    [5,[117.83,118.38,119.06,119.06,119.11, 'green', 'red']],
    [4,[117.26,117.89,117.89,118.38,118.51, 'green', 'red']],
    [3,[117.87,118.1,118.1,118.7,118.84, 'green', 'red']],
    [2,[118.61,118.7,119.14,119.14,119.76, 'green', 'red']],
    [1,[118,118.31,118.31,118.35,118.53, 'green', 'red']]
  ]
  @labels = [
    ['10/28', 5],
    ['10/27', 4],
    ['10/26', 3],
    ['10/25', 2],
    ['10/22', 1]
  ]
  erb :'index.html'
end