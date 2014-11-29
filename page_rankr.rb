# -*- coding: utf-8 -*-
require 'page_rankr'

target_url = 'zozo.jp/'

puts PageRankr.backlinks(target_url, :google, :bing, :yahoo, :alexa)
puts PageRankr.indexes(target_url, :google, :bing, :yahoo)
puts PageRankr.ranks(target_url, :google)
