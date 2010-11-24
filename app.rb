require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require(:default)

require 'app/base'
require 'config/config'

set :views, root_path("app", "views")
load_app 'helpers'
load_app 'controllers'
load_app 'models'

class Doji
  H_LINES = 5

  CHART_PROPERTIES = {
    :candle => {
      'chart.boxplot.width' => 15
    },
    :line => {
      'chart.line' => true,
      'chart.line.colors' => ['blue', 'blue'],
      'chart.tickmarks' => nil
    }
  }
end