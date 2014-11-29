# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('https://twitter.com/TwitterJP'))
doc.xpath("//div[@data-component-term='tweet']").each {|tweet|
	puts tweet.xpath(".//p[@class='ProfileTweet-text js-tweet-text u-dir']").text
}

