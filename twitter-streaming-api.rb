# -*- coding: utf-8 -*-
require 'twitter'

config = {
	consumer_key: '',
	consumer_secret: '',
	access_token: '',
	access_token_secret: ''
}

client = Twitter::Streaming::Client.new(config)

client.sample do |tweet|
	if tweet.is_a?(Twitter::Tweet)
		puts tweet.text if tweet.lang == 'ja'
		puts '-------------------------------'
	end
end
