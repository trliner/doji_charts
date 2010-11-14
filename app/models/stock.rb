class Stock
  include DataMapper::Resource

  property :id,     Serial
  property :symbol, String, :required => true, :unique => true

  has n, :stock_quotes

end