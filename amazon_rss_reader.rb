# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

url = "http://www.amazon.co.jp/rss/bestsellers/books/466282"
xml = Nokogiri::XML(open(url).read)

puts xml.xpath('/rss/channel/title').text

item_nodes = xml.xpath('//item')
item_nodes.each{|item|
	puts item.xpath('title').text
	puts item.xpath('link').text.match(%r!dp/(.+?)/!)[1]
}
