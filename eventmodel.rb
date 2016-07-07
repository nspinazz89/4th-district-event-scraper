# Event class
class Event
	def initialize(title, date, url, location)
		@title = title
		@date = date
		@url = url
		@location = location
	end

	def get_title
		@title
	end

	def get_date
		@date
	end

	def get_url
		@url
	end

	def get_location
		@location
	end

	def show
		puts @title
		puts @date
		puts @url
		puts @location
	end
end