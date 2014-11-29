# -*- coding: utf-8 -*-
require 'cgi'
require 'open-uri'
require 'rss'
require 'kconv'
require 'webrick'

class Site
	def initialize(url: '', title: '')
		@url, @title = url, title
	end
	attr_reader :url, :title

	def page_source
		@page_source ||= open(@url, &:read).toutf8
	end

	def output(formatter_klass)
		formatter_klass.new(self).format(parse)
	end
end

class SbcrTopics < Site
	def parse
		topic_dates     = page_source.scan(%r!(\d+)年 ?(\d+)月 ?(\d+)日<br />!)
		urls_and_titles = page_source.scan(%r!^<a href="(.+?)">(.+?)</a><br />!)

		urls_and_titles.zip(topic_dates).map{
			|(aurl, atitle),ymd|
			[CGI.unescapeHTML(aurl), CGI.unescapeHTML(atitle), Time.local(*ymd)]
		}
	end
end


class Formatter
	def initialize(site)
		@url = site.url
		@title = site.title
	end
	attr_reader :url, :title
end

class TextFormatter < Formatter
	def format(url_title_time_ary)
		s = "\n-----------------------\nTitle: #{title}, URL: #{url}\n-----------------------\n\n"
		url_title_time_ary.each do |aurl, atitle, atime|
			s << "(#{atime})#{atitle}\n"
			s << "#{aurl}\n\n"
		end
		s << '-----------------------'
	end
end

class RssFormatter < Formatter
	def format(url_title_time_ary)
		RSS::Maker.make('2.0') do |maker|
			maker.channel.updated = Time.now.to_s
			maker.channel.link = url
			maker.channel.title = title
			maker.channel.description = title

			url_title_time_ary.each do |aurl, atitle, atime|
				maker.items.new_item do |item|
					item.link = aurl
					item.title = atitle
					item.updated = atime
					item.description = atitle
				end
			end
		end
	end
end

class RSSServlet < WEBrick::HTTPServlet::AbstractServlet
	def do_GET(req, res)
		p '-----'
		p @options
		klass, opts = @options
		res.body = klass.new(opts).output(RssFormatter).to_s
		res.content_type = "application/xml; charset=utf-8"
	end
end

def start_server
	srv = WEBrick::HTTPServer.new(
		BindAddress: '127.0.0.1',
		Port: 7777)
	srv.mount('/rss.xml', RSSServlet, SbcrTopics,
		url: 'http://crawler.sbcr.jp/samplepage.html',
		title: 'SBCRトピック')
	trap('INT'){ srv.shutdown }
	srv.start
end

if ARGV.first == 'server'
	start_server
else
	site = SbcrTopics.new(url: 'http://crawler.sbcr.jp/samplepage.html', title: 'SBCRトピック')

	case ARGV.first
	when 'rss_output'
	 puts site.output RssFormatter
	when 'text_format'
	 puts site.output TextFormatter
	end
end

