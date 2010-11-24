module ChartDataHelpers

  def chart_data(range, line_type = :candle)
    chart_data = {}

    chart_data[:title] = chart_title(range.first, range.last)
    chart_data.merge!(y_min_and_max(range))
    chart_data[:x_max] = range.count + 1
    chart_data[:properties] = Doji::CHART_PROPERTIES[line_type]
    chart_data.merge!(label_and_line_type_data(range, line_type))

    chart_data
  end

  def chart_title(first_quote, last_quote)
    "#{first_quote.stock.symbol}: #{first_quote.date.strftime("%m/%d/%Y")}" +
    " - #{last_quote.date.strftime("%m/%d/%Y")}"
  end

  def y_min_and_max(range)
    range_low = range.all(:order => :low).first.low
    range_high = range.all(:order => :high).last.high
    price_range = range_high - range_low

    y_range = y_range(price_range)
    y_padding = (y_range - price_range) / 2
    y_min = round_to_increment(range_low - y_padding)
    y_max = y_min + y_range

    {:y_min => y_min, :y_max => y_max}
  end

  def y_range(price_range)
    scaling_factor = 1.5
    scaled_price_range = price_range * scaling_factor
    min_label_spacing = scaled_price_range / (Doji::H_LINES + 1)

    y_range = round_to_increment(min_label_spacing, :ceil) * Doji::H_LINES
  end

  def round_to_increment(price, method = :round)
    price_increment = 0.25
    (price / price_increment).send(method) * price_increment
  end

  def label_and_line_type_data(range, line_type)
    [:label, line_type].inject({}) do |hash, data_type|
      data = []
      range.each_with_index do |quote, time|
        data << quote.send(data_type, time + 1)
      end
      hash.merge!(data_type => data)
    end
  end

end