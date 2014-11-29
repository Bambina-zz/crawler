# -*- coding: utf-8 -*-

require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'URI'

Capybara.current_driver = :selenium
Capybara.app_host = "http://www.yahoo.co.jp/"
Capybara.default_wait_time = 20

module Crawler
	class LinkChecker
		include Capybara::DSL

		def initialize
			visit ''
		end

		def find_links
			base = URI.parse(Capybara.app_host)
			@links = []
			all('a').each do |a|
				u = a[:href]
				next if u.nil? or u.empty? or URI.parse(u).host != base.host
				@links << u
				break if @links.size >= 10
			end
			@links.uniq!
			@links
		end

		def screenshot(link)
			puts link
			visit(link)
			page.save_screenshot("1.png")
		end

	end
end

crawler = Crawler::LinkChecker.new
links = crawler.find_links
links.each {|link|
	crawler.screenshot(link)
}
