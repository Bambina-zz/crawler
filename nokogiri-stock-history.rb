# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

def get_nokogiri_doc(url)
	begin
		html = open(url)
	rescue OpenURI::HTTPError
		return
	end
	Nokogiri::HTML(html.read, nil, 'utf-8')
end

def has_next_page?(doc)
	doc.xpath("//*[@id='main']/ul/a").each {|element|
		return true if element.text == '次へ'
	}
	return false
end

def get_daily_data(doc)
	doc.xpath("//table[@class='boardFin yjSt marB6']/tr").each {|element|
		if element.children[1].text != "日付" && element.children[1][:class] != "through"
			day = element.children[0].text
			open_price = element.children[1].text
			high_price = element.children[2].text
			low_price  = element.children[3].text
			closing_price  = element.children[4].text
			volume = element.children[5].text.gsub(/,/,'')
			puts "#{day}, #{open_price}, #{high_price}, #{low_price}, #{closing_price}, #{volume}"
		end
	}
end

code = '4689'
year = '2014' #1983~
day = Time.now
ey = day.year
em = day.month
ed = day.day

start_url = "http://info.finance.yahoo.co.jp/history/?code=#{code}.T&sy=#{year}&sm=1&sd=1&ey=#{ey}&em=#{em}&ed=#{ed}&tm=d"
num = 1
puts '日付、始値、高値、安値、終値、出来高'
loop {
	url = "#{start_url}&p=#{num}"
	doc = get_nokogiri_doc(url)
	get_daily_data(doc)
	break if !has_next_page?(doc)
	num += 1
}
