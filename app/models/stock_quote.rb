class StockQuote
  include DataMapper::Resource

  property :id,       Serial
  property :stock_id, Integer,  :required => true
  property :date,     Date,     :required => true
  property :open,     Decimal,  :required => true,  :scale => 2
  property :close,    Decimal,  :required => true,  :scale => 2
  property :high,     Decimal,  :required => true,  :scale => 2
  property :low,      Decimal,  :required => true,  :scale => 2

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

  def label(time)
    #[title, time]
    [date.strftime("%m/%d"), time]
  end

  def candle(time)
    #[time, [low, lower(open, last), open < last ? lower : higher,higher(open, last), high, up_color, down_color]]
    [time, price_array << 'green' <<'red']
  end

  def line(time)
    #[time, close]
    [time, close]
  end

  def price_array
    [low, body_low, open, body_high, high].
      collect { |x| x.to_f }
  end

  def body_high
    open > close ? open : close
  end

  def body_low
    open > close ? close : open
  end

end