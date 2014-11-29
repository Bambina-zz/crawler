# -*- coding: utf-8 -*-
require 'amazon/ecs'


Amazon::Ecs.options = {
	associate_tag: 'test_app',
	AWS_access_key_id: '',
	AWS_secret_key: ''
}

res = Amazon::Ecs.item_lookup('4797380357', response_group: 'Small, ItemAttributes, Images', country: 'jp')

puts res.items.first.get('ItemAttributes/Title')

