require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeNatchitoches (titles, dates, urls, locations)
	beginLength = titles.length
	count = 0
	# had to do this because next link button on website randomly skips months :(
	currentMonth = 6
	puts "Beginning to scrape Natchitoches event list..."
	link = "http://www.natchitochesla.gov/calendar-node-field-date/"
	location = "Natchitoches"
	
	while count < 6 do
		titleCss = "div.views-field.views-field-colorbox span.field-content h1"
		dateCss = "div.field-content span.date-display-single"
		# get data from current calendar page
		getsDataMultiple(link, titleCss, dateCss, titles, dates, urls, locations, location)

		# goes to the next page, had to use this ugly hack method instead of getsNext helper function because of faulty website
		currentMonth = currentMonth + 1
		newLink = "http://www.natchitochesla.gov/calendar-node-field-date/month/2016-#{currentMonth}"
		link = newLink
		count = count + 1
	end

	# showData(titles, dates, urls, locations)
	
	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of Natchitoches event list"
	return titles, dates, urls, locations
end