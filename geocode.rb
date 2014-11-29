# -*- coding: utf-8 -*-
require 'geocoder'

Geocoder.configure(language: 'ja', units: 'km')
addresses = Geocoder.search('550-0014', params: {countorycodes: 'ja'})

addresses.each {|address|
	address.data['address_components'].each {|val|
		if val['short_name'] == 'JP'
			puts address.data['geometry']['location']
		end
	}
}
