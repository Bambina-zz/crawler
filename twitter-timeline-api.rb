# -*- coding: utf-8 -*-
require 'twitter'

config = {
	consumer_key: '',
	consumer_secret: '',
	access_token: '',
	access_token_secret: ''
}

client = Twitter::REST::Client.new(config)

client.user_timeline('u_uo0').each {|tweet|
	puts tweet.created_at
	puts tweet.text
	puts tweet.retweet_count.to_s
	puts tweet.favorite_count.to_s
	puts tweet.geo if !tweet.geo.nil?
	puts '-------------------------------'
}
