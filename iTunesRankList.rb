# -*- coding: utf-8 -*-
require 'open-uri'

url = 'https://itunes.apple.om/WebObjects/MZStore.woa/wa/viewTop?genreId=6015&id=25177&popId=47'
user_agent = 'iTunes/11.1.2 (Macintosh; OS X 10.8.4) AppleWebKit/536.30.1\r\n'

puts open(url, 'User-Agent' => user_agent).read

