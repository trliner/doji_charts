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

DataMapper.setup(:default, {
  :adapter  => 'mysql',
  :host     => 'localhost',
  :username => 'root' ,
  :password => '',
  :database => 'doji_development'})

DataMapper.auto_upgrade!

load_app 'helpers'
load_app 'models'