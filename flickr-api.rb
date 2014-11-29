# -*- coding: utf-8 -*-
require 'flickraw'

FlickRaw.api_key = ''
FlickRaw.shared_secret = ''
tag = 'cat'

images = flickr.photos.search(
	tags: tag,
	sort: 'relevance',
	per_page: 10
	)

images.each{|image|
	url = FlickRaw.url image;
	puts url
}
