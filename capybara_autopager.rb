# -*- coding: utf-8 -*-

require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'multi_json'
require 'autopagerize'

Capybara.current_driver = :selenium
Capybara.app_host = "http://www.amazon.co.jp/s/ref=nb_sb_noss_1?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&url=search-alias%3Daps&field-keywords=ruby"
Capybara.default_wait_time = 20

module Crawler
	class LinkChecker
		include Capybara::DSL

		def initialize()
			visit('')
			url = Capybara.app_host
			siteinfo = MultiJson.load(File.read("site_info.json"))
			@pages = Autopagerize.new(url, siteinfo, maxpage: 3)
		end

		def get_nextlink
			page_number = 1
			@pages.each do |page|
				visit(page.nextlink)
				save_screenshot("ss#{page_number}.png")
				page_number += 1
			end
		end
	end
end

crawler = Crawler::LinkChecker.new
crawler.get_nextlink

