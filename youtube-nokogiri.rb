# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'uri'

urls = []
search_word = URI.encode('new girl')
url = "https://www.youtube.com/results?search_query=#{search_word}"

doc = Nokogiri::HTML(open(url))
elements = doc.xpath("//h3[@class='yt-lockup-title']/a")
elements.each {|element|
	code = element.attributes['href'].value
	urls << "https://www.youtube.com" + code if code.include?('watch')
}

urls.each{|url|
	puts url
	doc = Nokogiri::HTML(open(url), nil, 'UTF-8')
	title = doc.xpath("//h1['watch-headline-title']/span").text.gsub(/\n/,'')
	puts title
}
