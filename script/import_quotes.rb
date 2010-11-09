require 'app.rb'

doc = Nokogiri::XML(File.open("public/data/SPY-daily.xml"))

doc.css("HistoricalQuote").each do |quote|
  StockQuote.create(
    :date => quote.at_css("Date").content,
    :open => quote.at_css("Open").content,
    :close => quote.at_css("Last").content,
    :low => quote.at_css("Low").content,
    :high => quote.at_css("High").content
  )
end