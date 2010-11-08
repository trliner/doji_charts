def y_min_and_max(data)
  data_low = data.collect {|d| d[1][0]}.sort.first
  data_high = data.collect {|d| d[1][4]}.sort.last
  data_range = data_high - data_low

  chart_range = (data_range * 1.5 / (Doji::H_LINES + 1) / 0.25).ceil * 0.25 * Doji::H_LINES
  chart_padding = (chart_range - data_range) / 2
  y_min = ((data_low - chart_padding) / 0.25).round * 0.25
  y_max = y_min + chart_range
  [y_min, y_max]
end