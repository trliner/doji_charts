require 'app.rb'

xml_files = Dir.glob("public/data/*-daily.xml")

xml_files.each do |file|
  doc = Nokogiri::XML(File.open(file))

  stock = Stock.create(:symbol => doc.at_css("Symbol").content.upcase)

  doc.css("HistoricalQuote").each do |quote|
    StockQuote.create(
      :date => quote.at_css("Date").content,
      :stock_id => stock.id,
      :open => quote.at_css("Open").content,
      :close => quote.at_css("Last").content,
      :low => quote.at_css("Low").content,
      :high => quote.at_css("High").content
    )
  end
end