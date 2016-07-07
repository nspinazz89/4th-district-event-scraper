require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeSabine (titles, dates, urls, locations)
	beginLength = titles.length
	count = 0
	puts "Beginning to scrape Sabine event list..."
	link = "http://www.toledobendlakecountry.com/do/calendar-of-events"
	location = "Sabine"
	while count < 3
		handleCss = "div.view-content div.views-field.views-field-field-image div.field-content a"
			
			#open link and get paths
		paths = getPathsAppend(link, handleCss, "http://www.toledobendlakecountry.com")

		# showPaths(paths)
			
		titleCss = "div.content div.field-items h2"
		dateCss = "div.content div.field.field-name-field-event-date.field-type-datetime.field-label-inline.clearfix div.field-items"

		# append data to titles, dates, and urls arrays
		paths.each do |path|
			getData(path, titleCss, dateCss, titles, dates, urls, locations, location)
		end

		# gets next link
		if count == 0
			newLink = "http://www.toledobendlakecountry.com/do/calendar-of-events?page=1"
			link = newLink
		else
			newLink = "http://www.toledobendlakecountry.com/do/calendar-of-events?page=2"
			link = newLink
		end
		count = count + 1
	end
	
	# showData(titles, dates, urls, locations)
	
	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of Sabine event list"
	return titles, dates, urls, locations
end