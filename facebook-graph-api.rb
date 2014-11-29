# -*- coding: utf-8 -*-
require 'koala'


graph = Koala::Facebook::API.new('')

search = graph.search('猫')
search.each{|result|
	puts result['message']
	who = graph.get_object(result['from']['id'].to_s)
	puts who['gender'].to_s
	puts who['birthday'].to_s
}
