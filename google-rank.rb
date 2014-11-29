# -*- coding: utf-8 -*-
require 'google-search'

def find_item(uri, query)
	search = Google::Search::Web.new do |search|
		search.query = query
		search.size = :large
		search.each_response {puts '.'}
	end
	puts uri
	search.find {|item| item.uri =~ uri}
end

def rank_for(domain,query)
	print "%s " % query

	if item = find_item(/#{domain}/, query)
		puts "%d" % (item.index)
	else
		puts 'Not found'
	end
end

regular_expression_domain = 'takuros\.net'
target_word = 'ruby クローラー'
rank_for(regular_expression_domain, target_word)

