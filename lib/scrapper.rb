require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

# Utiliser XPath pour sélectionner toutes les lignes du tableau
rows = page.xpath('//table//tr')
all_together = []

# Parcourir chaque ligne et extraire les données des colonnes 2 et 5
rows.each do |row|
  # Utiliser XPath pour sélectionner les cellules des colonnes 2 et 5
  name = row.xpath('./td[2]').text.strip
  price = row.xpath('./td[5]').text.strip
  unless name == "" || price == ""
    hash = { name => price }
    all_together << hash
  end
end
puts all_together