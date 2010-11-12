class StockQuote
  include DataMapper::Resource

  property :id,     Serial
  property :date,   Date,     :required => true
  property :open,   Decimal,  :required => true,  :scale => 2
  property :close,  Decimal,  :required => true,  :scale => 2
  property :high,   Decimal,  :required => true,  :scale => 2
  property :low,    Decimal,  :required => true,  :scale => 2

  def self.range(start_date, end_date)
    self.all(:date.gte => start_date, :date.lte => end_date).
      all(:order => :date)
  end

  def self.chart_data(range)
    chart_data = []
    time = 1
    range.each do |quote|
      #[time, [low, lower(open, last), open < last ? lower : higher,higher(open, last), high, up_color, down_color]]
      chart_data << [time, quote.price_array << 'green' <<'red']
      time += 1
    end
    chart_data
  end

  def self.labels(range)
    labels = []
    time = 1
    range.each do |quote|
      #[title, time]
      labels << [quote.date.to_s, time]
      time += 1
    end
    labels
  end

  def self.chart_title(range)
    "SPY: #{range.first.date.to_s} - #{range.last.date.to_s}"
  end

  def price_array
    high_low = if self.open > self.close
      [self.open, self.close]
    else
      [self.close, self.open]
    end
    [self.low, high_low.last, self.open, high_low.first, self.high].
      collect { |x| x.to_f }
  end

end