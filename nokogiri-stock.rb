# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

class CompanyInfo
	def initialize(ticker_code)
		@baseurl = "http://stocks.finance.yahoo.co.jp/stocks"
		@tickerCode = ticker_code
		scrape
	end

	attr_reader :name, :tickerCode, :category,
				:unit, :recentHighPrice, :recentLowPrice,
				:highPrice, :lowPrice, :price

	private
	def scrape_stock_info(html, index)
	end

	def get_company_info
		url = "#{@baseurl}/profile/?code=#{@tickerCode}"
		doc = get_nokogiri_doc(url)
		@name = doc.xpath("//th[@class='symbol']/h1").text
		@category = doc.xpath("//table[@class='boardFinCom marB6']/tr[6]/td").text
		@unit = doc.xpath("//table[@class='boardFinCom marB6']/tr[13]/td").text
	end

	def get_stock_info
		url = "#{@baseurl}/detail/?code=#{@tickerCode}"
		doc = get_nokogiri_doc(url)
		@recentHighPrice = doc.xpath("//div[11]/dl/dd/strong").text
		@recentLowPrice  = doc.xpath("//div[12]/dl/dd/strong").text
		@highPrice = doc.xpath("//div[@class='innerDate']/div[3]/dl/dd/strong").text
		@lowPrice = doc.xpath("//div[@class='innerDate']/div[4]/dl/dd/strong").text
		@price = doc.xpath("//td[@class=\"stoksPrice\"]").text
	end

	def get_nokogiri_doc(url)
		begin
			html = open(url)
		rescue OpenURI::HTTPError
			return
		end
		Nokogiri::HTML(html.read, nil, 'utf-8')
	end

	def scrape
		get_company_info
		get_stock_info
	end
end

company = CompanyInfo.new('4689')
puts company.name
puts company.category
puts company.unit
puts '年初来高値:'+company.recentHighPrice
puts '年初来安値:'+company.recentLowPrice
puts '高値:'+company.highPrice
puts '安値:'+company.lowPrice
puts '株価:'+company.price+'円'


