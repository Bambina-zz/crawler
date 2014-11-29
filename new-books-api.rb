# -*- coding: utf-8 -*-
require 'amazon/ecs'

Amazon::Ecs.options = {
	associate_tag: 'test_app',
	AWS_access_key_id: '',
	AWS_secret_key: ''
}

day = Time.now
power = "pubdate:during #{day.month}-#{day.year}"
res = Amazon::Ecs.send_request({
	operation: 'ItemSearch',
	search_index: 'Books',
	sort: 'daterank',
	country: 'jp',
	power: power
	})

res.items.each{|item|
	puts item.get('ASIN')
	puts item.get('ItemAttributes/Title')
}
