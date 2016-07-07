require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeCaddo(titles, dates, urls, locations)
	puts "Beginning to scrape from Caddo Republicans..."
	location = "Shreveport/Bossier"

	link = "http://new.caddogop.com/events/list"
	
	# showPaths(paths)

	titleCss = "h2.tribe-events-list-event-title a"
	dateCss = "div.tribe-event-schedule-details"
	
	getsDataMultiple(link, titleCss, dateCss, titles, dates, urls, locations, location)
	# showData(titles, dates, urls, locations)


	puts "Added #{titles.length} events"

	puts "Completed scraping of Caddo Republicans"

	return titles, dates, urls, locations
end