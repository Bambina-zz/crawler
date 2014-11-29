class NewsSite
	attr_reader :base_url, :url

	def initialize(site)
		@site = site
		@base_url = site.base_url
		@url = site.url

		methods.each do |method|
			if !@site.respond_to?(method.to_sym)
				raise "Site adapter must support method #{method}"
			end
		end
	end

	def scrape(doc)
		@site.scrape(doc)
	end
end

