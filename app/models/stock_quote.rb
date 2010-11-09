class StockQuote
  include DataMapper::Resource

  property :id,     Serial
  property :date,   Date,     :required => true
  property :open,   Decimal,  :required => true,  :scale => 2
  property :close,  Decimal,  :required => true,  :scale => 2
  property :high,   Decimal,  :required => true,  :scale => 2
  property :low,    Decimal,  :required => true,  :scale => 2
end