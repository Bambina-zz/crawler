# -*- coding: utf-8 -*-
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = "https://affiliate.amazon.co.jp/"

module Crawler
	class Amazon
		include Capybara::DSL

		def login
			visit '/'
			fill_in 'username', with: ''
			fill_in 'password', with: ''
			click_button "サインイン"
		end

		def portal
			select '昨日', from: 'preSelectedPeriod'
			first('.line-item-links').click_link('レポート全体を表示')
		end

		def report
			within(:xpath, "//*[@class='totals']") do
				puts "発送済み商品合計:"+all('td')[1].text
				puts "売り上げ:"+all('td')[2].text
				puts "紹介料:"+all('td')[3].text
			end
		end
	end
end

crawler = Crawler::Amazon.new
crawler.login
crawler.portal
crawler.report
