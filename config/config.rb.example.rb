DataMapper.setup(:default, {
  :adapter  => 'mysql',
  :host     => 'localhost',
  :username => 'root' ,
  :password => '',
  :database => 'doji_development'})

DataMapper.auto_upgrade!