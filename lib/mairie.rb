require 'nokogiri'
require 'open-uri'
require 'pry'

def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url))

  rows = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]')
  name = page.xpath('/html/body/div/main/section[1]/div/div/div/h1').text.strip
  all_together = []

  rows.each do |row|
    mail = row.xpath('./td[2]').text.strip
    unless mail == ""
      hash = { name => mail }
      all_together << hash
    end
  end
  puts all_together
end

def get_townhall_urls
  page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))

  as = page.xpath('//a[@class="lientxt"]/@href')
  all_links = []
  url_prefix = "https://www.annuaire-des-mairies.com"
  
  as.each do |row|
    href = row.text
    unless href.empty?
      url = url_prefix + href[1..-1]
      all_links << url
    end
  end

  all_links.each do |url|
    get_townhall_email(url)
  end
end

get_townhall_urls
