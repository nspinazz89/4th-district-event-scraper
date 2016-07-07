require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeLeesville (titles, dates, urls, locations)
	beginLength = titles.length
	count = 0
	puts "Beginning to scrape Leesville event list..."
	link = "http://www.chambervernonparish.com/events/"
	location = "Leesville"
	
	handleCss = "div.mn-title a"
	
	#open link and get paths
	paths = getPaths(link, handleCss)

	#showPaths(paths)
	
	titleCss = "div.mn-event-section.mn-event-name span.mn-event-content"
	dateCss = "div.mn-event-datetime span.mn-event-day"

	# append data to titles, dates, and urls arrays
	paths.each do |path|
		getData(path, titleCss, dateCss, titles, dates, urls, locations, location)
	end
	
	# showData(titles, dates, urls, locations)
	
	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of Leesville event list"
	return titles, dates, urls, locations
end