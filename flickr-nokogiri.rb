# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'uri'
require 'cgi'

def save_image(url)
	filename = File.basename(url)
	open("files/"+filename.to_s, 'wb') do |file|
		open(url) do |data|
			file.write(data.read)
		end
	end
end

search_word = URI.encode('cat')
doc = Nokogiri::HTML(open("https://www.flickr.com/search/?q=#{search_word}"))

doc.xpath("//a[@class='rapidnofollow photo-click']/img").each {|link|
	url = link['data-defer-src']
	puts url
	save_image(url)
}
