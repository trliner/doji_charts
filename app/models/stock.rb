class Stock
  include DataMapper::Resource

  property :id,     Serial
  property :symbol, String, :required => true

end