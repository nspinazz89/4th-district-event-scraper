require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeBeauregard (titles, dates, urls, locations)
	beginLength = titles.length
	count = 0
	puts "Beginning to scrape Beauregard event list..."
	link = "http://www.beauchamber.org/events/calendar/"
	location = "Beauregard"
	while count < 6
		handleCss = "div.mn-cal-day.mn-cal-activedate ul li a"
		
		#open link and get paths
		paths = getPaths(link, handleCss)

		#showPaths(paths)
		
		titleCss = "div#mn-pagetitle h1"
		dateCss = "span.mn-event-content span.mn-event-day"

		# append data to titles, dates, and urls arrays
		paths.each do |path|
			getData(path, titleCss, dateCss, titles, dates, urls, locations, location)
		end

		# gets next link
		newLink = getsNext(link, "span.mn-cal-next a")
		link = newLink
		count = count + 1
	end
	
	# showData(titles, dates, urls, locations)
	
	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of Beauregard event list"
	return titles, dates, urls, locations
end