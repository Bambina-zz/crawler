# -*- coding: utf-8 -*-

require 'anemone'
require 'nokogiri'
require 'kconv'

#urls = ["http://www.amazon.co.jp/gp/bestsellers/books/",
#		"http://www.amazon.co.jp/gp/bestsellers/digital-text/2275256051/"]

urls = []
urls.push("http://www.amazon.co.jp/gp/bestsellers/books/466282")
urls.push("http://www.amazon.co.jp/gp/bestsellers/books/466298")
urls.push("http://www.amazon.co.jp/gp/bestsellers/digital-text/2291905051")
urls.push("http://www.amazon.co.jp/gp/bestsellers/digital-text/2291657051")

Anemone.crawl(urls, depth_limit: 0) do |anemone|
	# anemone.focus_crawl do |page|
	# 	page.links.keep_if{ |link|
	# 		link.to_s.match(/\/gp\/bestsellers\/books|\/gp\/bestsellers\/digital-text/)
	# 	}
	# end

	# PATTERN = %r[466298\/+|466282\/+|2291657051\/+|2291905051\/+]
	# anemone.on_pages_like(PATTERN) do |page|
	# 	puts page.url
	# end

	anemone.on_every_page do |page|
		doc = Nokogiri::HTML.parse(page.body.toutf8)
		category    = doc.xpath("//*[@id='zg_browseRoot']/ul/li/a").text
		subcategory = doc.xpath("//*[@id='zg_listTitle']/span").text
		puts category+"/"+subcategory

		items  = doc.xpath("//*[@class=\"zg_itemRow\"]/div[1]/div[2]")
		items += doc.xpath("//*[@class=\"zg_itemRow\"]/div[2]/div[2]")
		items.each{|item|
			#順位
			puts item.xpath("div[1]/span[1]").text
			#署名
			puts item.xpath("div['zg_title']/a").text
			#ASIN
			puts item.xpath("div['zg_title']/a").attribute('href').text.match(%r!dp/(.+?)/!)[1]
		}
	end
end

