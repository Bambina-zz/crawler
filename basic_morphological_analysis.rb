# -*- coding: utf-8 -*-
require 'open-uri'
require 'rexml/document'

APPLICATION_ID = ''
BASE_URL = 'http://jlp.yahooapis.jp/MAService/V1/parse'

def request(text)
	app_id = APPLICATION_ID
	params = "?appid=#{app_id}&results=uniq&filter=9&uniq_filter=9"
	url    = "#{BASE_URL}#{params}" + "&sentence=" + URI.encode("#{text}")

	response = open(url)
	doc = REXML::Document.new(response).elements['ResultSet/uniq_result/word_list/']
	doc.elements.each('word'){|element|
		text  = element.elements['surface'][0]
		count = element.elements['count'][0]
		p "#{text}=#{count}"
	}
end

text = '赤鼻のトトロと赤鼻のトナカイはどちらも哺乳類ですが、もうすぐ出番なのはトナカイです'
request(text)

