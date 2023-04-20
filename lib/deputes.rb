require 'nokogiri'
require 'open-uri'
require 'pry'

def get_depute_mail
  page = Nokogiri::HTML(URI.open('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=900'))
  uls = page.xpath('//ul')
  all_together = []
  
  uls.each do |ul|
    name = ul.xpath('.//h2[@class="titre_normal"]').text.strip
    first_name, last_name = name.split(' ', 2)
    email = ul.xpath('.//a[contains(@href, "mailto") and contains(@href, "assemblee")]/text()').text.strip
    unless email == ""
      hash = { first_name: first_name,
      last_name: last_name, 
      email: email }
      all_together << hash
    end
  end
  puts all_together
end

get_depute_mail
