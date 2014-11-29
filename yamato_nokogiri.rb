# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'google_calendar'

if ARGV.size == 1
	ship_code = ARGV[0]
else
	puts 'input slip number'
	exit 1
end

def set_google_calendar(ship_code, status, day)
	cal = Google::Calendar.new(
		user_name: '',
		password: '',
		app_name: 'mycompany.com-googlecalendar-integration'
		)
	today = Time.now
	day_of_month = day.split(/\//)[1]
	month = day.split(/\//)[0]
	date = Time.local(today.year, month, day_of_month, 12, 00, 00)

	event = cal.create_event do |e|
		e.title = "ヤマト運輸#{ship_code}/#{status}"
		e.start_time = date
		e.end_time = date
	end

	puts event
end

Net::HTTP.version_1_2
url = "toi.kuronekoyamato.co.jp"
html = nil
Net::HTTP.start(url, 80){|http|
	response = http.post('/cgi-bin/tneko', "number01=#{ship_code}")
	html = response.body
}

if html.nil?
	exit
else
	html.encode!('UTF-8', 'Shift_JIS')
end
doc = Nokogiri::HTML(html) if html.nil?

doc.xpath("//table[@class='ichiran']/tr[3]").each {|element|
	day = element.xpath(".//*[@class='hiduke']/font").text
	status = element.xpath(".//*[@class='ct']/font").text
	puts day
	puts status
	set_google_calendar(ship_code, status, day)
}
