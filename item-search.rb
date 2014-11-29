# -*- coding: utf-8 -*-
require 'amazon/ecs'
require 'pp'

Amazon::Ecs.options = {
	associate_tag: 'test_app',
	AWS_access_key_id: '',
	AWS_secret_key: ''
}

opts = {
	country: 'jp',
	author: '江國香織'
}

res = Amazon::Ecs.item_search('に', opts)
res.items.each do |item|
	puts item.get('ItemAttributes/Title')
end

res = Amazon::Ecs.item_lookup(
	'B001JXJGXE',
	response_group: 'Small, ItemAttributes, Images',
	country: 'jp')

pp res
