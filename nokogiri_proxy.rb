# -*- coding: utf-8 -*-

require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(
	open('http://www.yahoo.co.jp',
		proxy: 'http://localhost:5432'))

puts doc.title

