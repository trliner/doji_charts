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

  def self.chart_data(type, range)
    chart_data = []
    time = 1
    range.each do |quote|
      chart_data << quote.send(type, time)
      time += 1
    end
    chart_data
  end

  def self.chart_title(range)
    "SPY: #{range.first.date.strftime("%m/%d/%Y")} - " +
    "#{range.last.date.strftime("%m/%d/%Y")}"
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