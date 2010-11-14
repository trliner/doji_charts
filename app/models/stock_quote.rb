class StockQuote
  include DataMapper::Resource

  CHART_DATA_TYPES = [:candle, :label]

  property :id,     Serial
  property :date,   Date,     :required => true
  property :open,   Decimal,  :required => true,  :scale => 2
  property :close,  Decimal,  :required => true,  :scale => 2
  property :high,   Decimal,  :required => true,  :scale => 2
  property :low,    Decimal,  :required => true,  :scale => 2

  belongs_to :stock
  validates_with_block :stock_present do
    self.stock.nil? ? [false, "Stock must be present"] : [true]
  end

  def self.range(start_date, end_date)
    self.all(:date.gte => start_date, :date.lte => end_date).
      all(:order => :date)
  end

  def self.most_recent
    self.first(:order => :date.desc)
  end

  def self.chart_data(range)
    chart_data = {}
    chart_data[:title] = chart_title(range.first, range.last)

    range_low = range.all(:order => :low).first.low
    range_high = range.all(:order => :high).last.high
    chart_data.merge!(y_min_and_max(range_low, range_high))
    chart_data[:x_max] = range.count + 1

    CHART_DATA_TYPES.each do |type|
      chart_data[type] = []
      time = 1
      range.each do |quote|
        chart_data[type] << quote.send(type, time)
        time += 1
      end
    end

    chart_data
  end

  def self.chart_title(first_quote, last_quote)
    "SPY: #{first_quote.date.strftime("%m/%d/%Y")} - " +
    "#{last_quote.date.strftime("%m/%d/%Y")}"
  end

  def self.y_min_and_max(range_low, range_high)
    price_range = range_high - range_low
    y_range, y_padding = y_range_and_padding(price_range)
    y_min = round_to_increment(range_low - y_padding)
    y_max = y_min + y_range
    {:y_min => y_min, :y_max => y_max}
  end

  def self.round_to_increment(price, method = :round)
    price_increment = 0.25
    (price / price_increment).send(method) * price_increment
  end

  def self.y_range_and_padding(price_range)
    scaling_factor = 1.5
    scaled_price_range = price_range * scaling_factor
    min_label_spacing = scaled_price_range / (Doji::H_LINES + 1)
    y_range = round_to_increment(min_label_spacing, :ceil) * Doji::H_LINES
    y_padding = (y_range - price_range) / 2
    [y_range, y_padding]
  end

  def label(time)
    #[title, time]
    [self.date.strftime("%m/%d"), time]
  end

  def candle(time)
    #[time, [low, lower(open, last), open < last ? lower : higher,higher(open, last), high, up_color, down_color]]
    [time, self.price_array << 'green' <<'red']
  end

  def price_array
    [self.low, self.body_low, self.open, self.body_high, self.high].
      collect { |x| x.to_f }
  end

  def body_high
    self.open > self.close ? self.open : self.close
  end

  def body_low
    self.open > self.close ? self.close : self.open
  end

end