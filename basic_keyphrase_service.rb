# -*- coding: utf-8 -*-
require 'open-uri'
require 'rexml/document'

APPLICATION_ID = ''
BASE_URL = 'http://jlp.yahooapis.jp/KeyphraseService/V1/extract'

def request(text)
	app_id = APPLICATION_ID
	params = "?appid=#{app_id}&output=xml"
	url    = "#{BASE_URL}#{params}" + "&sentence=" + URI.encode("#{text}")

	response = open(url)
	doc = REXML::Document.new(response).elements['ResultSet/']
	doc.elements.each('Result'){|element|
		text  = element.elements['Keyphrase'][0]
		score = element.elements['Score'][0]
		p "#{text}=#{score}"
	}
end

text = '赤鼻のトトロと赤鼻のトナカイはどちらも哺乳類ですが、もうすぐ出番なのはトナカイです'
request(text)
